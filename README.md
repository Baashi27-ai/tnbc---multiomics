# TNBC Multi-Omics (Bhaskararao Ch)

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Release](https://img.shields.io/badge/release-v1.0-blue.svg)](https://github.com/Baashi27-ai/tnbc---multiomics/releases/tag/v1.0)
[![GitHub repo size](https://img.shields.io/github/repo-size/Baashi27-ai/tnbc---multiomics)](https://github.com/Baashi27-ai/tnbc---multiomics)

---

### 📖 Project Overview
End-to-end analysis of Triple-Negative Breast Cancer (TNBC) using:
- *RNA-seq* (expression profiling)  
- *DNA methylation* (DMPs)  
- *Genomic mutations* (TMB, mutational profiling)  
- *Proteomics* (GSVA/PROGENy panels)  

Multi-omics integration was performed using *Similarity Network Fusion (SNF)* and *consensus clustering*, validated by survival analysis (KM/Cox) and enriched pathways.  
Model *explainability* was provided with *SHAP*.  

---

### ✨ Key Highlights
- *Integration:* SNF + consensus → stable TNBC subtypes  
- *Biology:* GO/Reactome enrichment, GSVA panels, PROGENy TF activity  
- *Outcomes:* Kaplan–Meier & Cox regression confirm prognostic separation  
- *Explainability:* SHAP summaries + feature prep scripts  

---

### 📂 Repository Layout

| Folder / File       | Description |
|---------------------|-------------|
| data/             | Input data (placeholders only, see data/README.md) |
| figures/          | All key plots (volcano, KM, Cox, SNF, SHAP, etc.) with guide |
| reports/          | Human-readable reports & slide decks |
| results/          | Processed outputs (plots, tables, checkpoints) |
| src/              | Source code scripts for full pipeline |
| env/              | Environment + session info |
| run_all.R         | Master script to run entire workflow |
| LICENSE           | MIT License |
| README.md         | Project overview & documentation |

---

### 📊 Example Figures
<p align="center">
  <img src="figures/Volcano_DESeq2_TNBC_vs_NonTNBC.png" alt="RNA-seq Volcano" width="45%"/>
  <img src="figures/SNF_UMAP.png" alt="SNF UMAP" width="45%"/>
</p>
<p align="center">
  <img src="figures/KM_SNF_clusters.png" alt="Kaplan-Meier by SNF clusters" width="45%"/>
  <img src="figures/shap_summary.png" alt="SHAP summary" width="45%"/>
</p>

---

