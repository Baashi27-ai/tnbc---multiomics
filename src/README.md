# Source Code Guide

This folder contains the core scripts used to run the TNBC multi-omics pipeline.  
Each script corresponds to a specific stage of the analysis.

---

### 📜 Scripts Overview
- *run_all.R* – Master runner script to execute the full pipeline (calls all steps in sequence).
- *geo_validate.R* – External validation of TNBC subtypes using GEO cohorts.
- *preprocess.R* – Data preprocessing: normalization, QC, and filtering for RNA-seq, methylation, proteomics, and mutations.
- *snf_consensus.R* – Integration of multi-omics data using Similarity Network Fusion and consensus clustering.
- *survival_analysis.R* – Kaplan–Meier and Cox proportional hazards survival analysis.
- *enrichment_analysis.R* – Pathway enrichment (GO, Reactome, PROGENy, GSVA panels).
- *shap_explain.R* – Model explainability and feature contribution via SHAP.
- *plot_utils.R* – Helper functions to generate publication-ready plots.

---

📌 All scripts are modular and can be run individually.  
📌 The run_all.R script reproduces the entire workflow end-to-end.
