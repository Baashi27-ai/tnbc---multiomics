args <- commandArgs(trailingOnly=TRUE)
if (length(args) < 3) stop("Need 3 args: <features.tsv> <model.rds> <out.tsv>")
x_file <- args[1]; m_file <- args[2]; out_file <- args[3]

suppressWarnings(suppressMessages({
  library(data.table)
  library(randomForest)
}))

cat("Reading features:", x_file, "\n")
X <- fread(x_file)
cat("Loading model:", m_file, "\n")
mdl <- readRDS(m_file)

# Choose ID column if present
id_col <- intersect(names(X), c("SID","sample_id","sample","ID","id"))
id_col <- if (length(id_col)) id_col[1] else NA_character_

# Expected features from model (fallback: all non-ID, non-label cols)
exp_feats <- try(rownames(mdl$importance), silent = TRUE)
if (inherits(exp_feats, "try-error") || is.null(exp_feats)) {
  exp_feats <- setdiff(names(X), c(id_col, "CC_cluster"))
}
exp_feats <- unique(exp_feats)

# Current feature columns we have
feat_cols <- intersect(names(X), exp_feats)

# Build feature matrix and add any missing columns as NA
DT <- as.data.table(X)
M  <- as.data.table(DT[, ..feat_cols])
missing <- setdiff(exp_feats, feat_cols)
if (length(missing)) {
  for (m in missing) M[[m]] <- NA_real_
}
# Order columns exactly like model expects
setcolorder(M, exp_feats)

# Coerce everything to numeric and clean non-finite
numify <- function(v) {
  v <- suppressWarnings(as.numeric(v))
  v[!is.finite(v)] <- NA_real_
  v
}
M[, (names(M)) := lapply(.SD, numify)]

# Impute NAs (numeric median/mode) with RF helper
M_imp <- as.data.table(randomForest::na.roughfix(as.data.frame(M)))

# Put SID first if we have an ID; name it 'SID' for downstream
if (!is.na(id_col)) {
  OUT <- cbind(SID = DT[[id_col]], M_imp)
} else {
  OUT <- M_imp
}

# Write cleaned matrix
fwrite(OUT, out_file, sep = "\t")
cat("Wrote cleaned features to:", normalizePath(out_file), "\n")