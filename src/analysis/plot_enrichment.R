suppressWarnings(suppressMessages({
    library(data.table); library(ggplot2); library(readr); library(here)
}))

args <- commandArgs(trailingOnly=TRUE)
if (length(args) < 3) stop("Usage: Rscript plot_enrichment.R <in.tsv> <out.png> <out.pdf>")

infile  <- args[1]
out_png <- args[2]
out_pdf <- args[3]

# Read the data using read_tsv from the readr package
dt <- read_tsv(infile, skip = 1, col_names = c("Class", "Tag", "Pathway", "Count", "pValue"), show_col_types = FALSE)

# Ensure the data is in the correct format for further processing
dt <- as.data.table(dt)

need <- c("Class","Tag","Pathway","Count","pValue")
miss <- setdiff(need, names(dt))
if (length(miss) > 0) stop(paste("Missing columns:", paste(miss, collapse=", ")))

dt$Count <- suppressWarnings(as.numeric(dt$Count))
dt$Count[!is.finite(dt$Count) | is.na(dt$Count)] <- 0
dt$ClassTag <- sprintf("%s : %s", dt$Class, dt$Tag)

p <- ggplot(dt, aes(x=reorder(ClassTag, Count), y=Count, fill=Class)) +
      geom_col() +
      coord_flip() +
      labs(title="Repurpose enrichment (counts by class/tag)",
           x="Class : Tag", y="Count") +
      theme_minimal(base_size=12)

# Create the output directory if it doesn't exist
output_dir <- "C:/Users/91779/Desktop/"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

# Use file.path for robust path creation
out_png_path <- file.path(output_dir, "repurpose_enrichment.png")
out_pdf_path <- file.path(output_dir, "repurpose_enrichment.pdf")

ggsave(filename=out_png_path, plot=p, width=7, height=5, dpi=150)
ggsave(filename=out_pdf_path, plot=p, width=7, height=5, dpi=200)

cat("Wrote:\n", out_png_path, "\n", out_pdf_path, "\n")