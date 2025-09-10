# Data Guide

This repository does not include raw patient data.  

To reproduce results, place your input files in data/ with these names:

- expression.tsv – gene x sample counts (RNA-seq)
- methylation.tsv – beta/M-values
- mutations.maf – somatic mutation MAF (for TMB/oncoplot)
- proteomics.tsv – protein abundance

👉 Example placeholders are provided in data/sample/.  
👉 Update paths in src/00_setup.R if your data files differ.
