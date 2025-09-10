suppressWarnings(suppressMessages({
  library(data.table); library(randomForest); library(fastshap); library(ggplot2)
}))

args <- commandArgs(trailingOnly=TRUE)
if (length(args) < 3) stop("Need 3 args: <features.tsv> <model.rds> <outdir>")
x_file <- args[[1]]; model_file <- args[[2]]; outdir <- args[[3]]

ts <- function(...) cat(format(Sys.time(), "%H:%M:%S"), "-", ..., "\n")

dir.create(outdir, showWarnings = FALSE, recursive = TRUE)

ts("Reading features:", x_file)
Xfull <- fread(x_file, sep = "\t", showProgress = FALSE)

# Expect a label + some ID; keep an ID for reporting
id_cols <- intersect(names(Xfull), c("SID","sample_id","sample","ID","id"))
lab_col <- "CC_cluster"
stopifnot(lab_col %in% names(Xfull))
if (length(id_cols) == 0) { Xfull[, SID := seq_len(.N)]; id_cols <- "SID" }

y  <- factor(Xfull[[lab_col]])
ids <- Xfull[, ..id_cols][[1]]

# Build feature matrix: drop IDs and label
drop_cols <- unique(c(id_cols, lab_col, "cc_name"))
X <- Xfull[, setdiff(names(Xfull), drop_cols), with = FALSE]

# Coerce to numeric (defensive)
for (j in seq_along(X)) {
  if (!is.numeric(X[[j]])) X[[j]] <- suppressWarnings(as.numeric(X[[j]]))
}
# Impute NAs with per-column median
for (j in seq_along(X)) {
  v <- X[[j]]; if (anyNA(v)) { med <- suppressWarnings(median(v, na.rm=TRUE)); if (!is.finite(med)) med <- 0; v[is.na(v)] <- med; X[[j]] <- v }
}

ts("Loading model:", model_file)
model <- readRDS(model_file)
if (!inherits(model, "randomForest")) stop("Model is not class 'randomForest'")

# Confirm probabilities work
ts("Probing class probabilities…")
prob <- predict(model, newdata = X, type = "prob")
classes <- colnames(prob)
ts("Classes:", paste(classes, collapse = ", "))

# Background sample for fastshap
set.seed(1L)
bg_size <- min(100L, nrow(X))
bg      <- X[sample.int(nrow(X), bg_size), ]

# Compute SHAP per class
nsim <- min(32L, max(8L, ceiling(ncol(X)/10)))
ts("nsim=", nsim, " bg=", bg_size)

all_sv <- list()
for (k in seq_along(classes)) {
  cls <- classes[k]
  ts("Computing SHAP for class:", cls)
  pf <- function(object, newdata) {
    as.numeric(predict(object, newdata = newdata, type = "prob")[, cls])
  }
  sv <- fastshap::explain(model, X = as.data.frame(X), pred_wrapper = pf,
                          nsim = nsim, newdata = as.data.frame(bg), adjust = TRUE)
  sv <- as.data.table(sv)
  sv[, SID := ids]
  sv_m <- melt(sv, id.vars = "SID", variable.name = "feature", value.name = "shap")
  sv_m[, class := cls]
  all_sv[[k]] <- sv_m
}
SV <- rbindlist(all_sv)

# Save long SHAP table
sv_path <- file.path(outdir, "shap_values_multiclass.tsv")
fwrite(SV[, .(SID, class, feature, shap, abs_shap = abs(shap))], sv_path, sep = "\t")
ts("Wrote:", sv_path)

# Summarize top features across classes
imp <- SV[, .(mean_abs = mean(abs_shap, na.rm=TRUE)), by = .(class, feature)]
top <- imp[order(class, -mean_abs), .SD[1:20], by = class]
top_path <- file.path(outdir, "shap_top20_multiclass.tsv")
fwrite(top, top_path, sep = "\t")
ts("Wrote:", top_path)

# One quick faceted plot
p <- ggplot(top, aes(x = reorder(feature, mean_abs), y = mean_abs)) +
     geom_col() + coord_flip() + facet_wrap(~class, scales = "free_y") +
     labs(x = "Feature", y = "Mean |SHAP|", title = "Top 20 features per class")
png(file.path(outdir, "shap_top20_multiclass.png"), width = 1800, height = 1200, res = 150)
print(p); dev.off()

ts("DONE.")