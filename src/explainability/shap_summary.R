suppressWarnings(suppressMessages({ library(data.table); library(ggplot2) }))

args <- commandArgs(trailingOnly=TRUE)
in_tsv <- args[1]; out_dir <- args[2]
png_out <- file.path(out_dir, "shap_summary.png")
top_tsv <- file.path(out_dir, "shap_top20.tsv")

dir.create(out_dir, showWarnings=FALSE, recursive=TRUE)
DT <- fread(in_tsv)

nms <- names(DT)

# Try to find columns, but DO NOT fail if SID is missing
sid_name <- if ("SID" %in% nms) "SID" else if ("sample_id" %in% nms) "sample_id" else if ("sample" %in% nms) "sample" else if ("id" %in% nms) "id" else NA
feat_name <- if ("feature" %in% nms) "feature" else if ("variable" %in% nms) "variable" else if ("feat" %in% nms) "feat" else NA
shap_name <- if ("shap_value" %in% nms) "shap_value" else if ("shap" %in% nms) "shap" else if ("phi" %in% nms) "phi" else if ("value" %in% nms) "value" else NA

if (is.na(feat_name)) stop("No feature column found (feature/variable/feat).")
if (is.na(shap_name)) stop("No SHAP value column found (shap_value/shap/phi/value).")

setnames(DT, feat_name, "feature", skip_absent=TRUE)
setnames(DT, shap_name, "shap_value", skip_absent=TRUE)
if (!is.na(sid_name)) setnames(DT, sid_name, "SID", skip_absent=TRUE)

# If no SID in file, synthesize a simple index (doesn't affect summaries)
if (!("SID" %in% names(DT))) {
  DT[, SID := seq_len(.N)]
}

# Ensure numeric shap_value
DT[, shap_value := as.numeric(shap_value)]
# abs shap (create if absent)
if (!("abs_shap" %in% names(DT))) DT[, abs_shap := abs(shap_value)]

# Top-20 by |SHAP| mean
Top <- DT[, .(mean_abs_SHAP = mean(abs_shap, na.rm=TRUE)), by=feature][order(-mean_abs_SHAP)]
Top <- Top[1:min(20, .N)]
fwrite(Top, top_tsv, sep="\t")

# Plot (only top20 to keep readable)
DTp <- merge(DT, Top, by="feature")
DTp[, feature := factor(feature, levels=rev(Top$feature))]

P <- ggplot(DTp, aes(x=abs(shap_value), y=feature)) +
  geom_point(alpha=0.35, size=0.8, position=position_jitter(height=0.15, width=0)) +
  stat_summary(fun=median, geom="point", size=2.0) +
  labs(x="|SHAP value| (impact on model output)", y=NULL,
       title="TNBC CC Classifier — SHAP Summary (Top 20 Features)",
       subtitle="Dots = per-sample contributions; black dot = median") +
  theme_minimal(base_size=11) +
  theme(panel.grid.major.y=element_blank(), panel.grid.minor=element_blank(),
        axis.text.y=element_text(size=9))

ggsave(png_out, P, width=8, height=6, dpi=150)
cat("Wrote:", normalizePath(png_out), "\n")
cat("Wrote:", normalizePath(top_tsv), "\n")