# 🧬 TNBC Multi-Omics (Bhaskarao Ch)

## 📖 Project Overview
End-to-end analysis of Triple-Negative Breast Cancer (TNBC) using:
- *RNA-seq* (expression profiling)  
- *DNA methylation* (DMPs)  
- *Genomic mutations* (TMB mutational profiling)  
- *Proteomics* (GSVA/PROGENy panels)  

Multi-omics integration was performed using Similarity Network Fusion (SNF) and consensus clustering, validated by survival analysis (KM/Cox) and pathway enrichment (GO/GSVA/PROGENy).  
Model explainability was provided with SHAP.

---

## ✨ Key Highlights
- Integration: SNF + consensus → stable TNBC subtypes  
- Biology: GO/Reactome enrichment; GSVA panels; PROGENy TF activity  
- Outcomes: Kaplan-Meier & age-adjusted Cox confirm prognostic separation  
- Explainability: SHAP summaries + feature prep scripts  

---

## 📂 Repository Layout

| Folder / File | Description |
|---------------|-------------|
| data/       | Input data (placeholders only; see data/README.md) |
| figures/    | All key plots (Volcano, KM, Cox, SNF, SHAP, etc.) with guide |
| reports/    | Human-readable reports & slide decks |
| results/    | Processed outputs (plots, tables, checkpoints) |
| src/        | Source code scripts for full pipeline |
| env/        | Environment & session info |
| run_all.R   | Master script to run entire workflow |
| LICENSE     | MIT License |
| README.md   | Project overview & documentation |

---

## 🖼 Example Figures

<p align="center">
  <img src="figures/volcano_DESeq2_TNBC_vs_NonTNBC.png" alt="RNA-seq Volcano" width="45%"/>
  <img src="figures/volcano_Methylation_TNBC_vs_NonTNBC.png" alt="Methylation Volcano" width="45%"/>
</p>

<p align="center">
  <img src="figures/venn_deg_dmp.png" alt="DEG-DMP Overlap" width="45%"/>
  <img src="figures/SNF_UMAP.png" alt="SNF UMAP Clusters" width="45%"/>
</p>

<p align="center">
  <img src="figures/KM_SNF_clusters.png" alt="Kaplan-Meier by SNF Clusters" width="45%"/>
  <img src="figures/cox_forest_by_cluster.png" alt="Cox Regression Forest" width="45%"/>
</p>

<p align="center">
  <img src="figures/GO_BP_HypoUp_top15.png" alt="GO BP HypoUp Pathways" width="45%"/>
  <img src="figures/shap_summary.png" alt="SHAP Feature Summary" width="45%"/>
</p>

---

## 🔧 Workflow (end-to-end)

*Inputs → Processing → Outputs*

- *Input data:* RNA-seq counts, DNA methylation (DMPs), Mutations (MAF/TMB), Proteomics (GSVA/PROGENy)  
- *Processing:* QC & normalization → SNF integration → Consensus clustering  
- *Outputs:* Survival analysis (KM/Cox), Pathway enrichment (GO/Reactome), Explainability (SHAP)  

---

## 🚀 Getting Started

Clone the repository and run the master script:

bash
git clone https://github.com/Baashi27-ai/tnbc---multiomics.git
cd tnbc---multiomics
Rscript run_all.R


### Requirements
This pipeline was developed and tested in *R 4.3*.  
Install the following R packages before running:

r
install.packages(c("tidyverse","data.table","ComplexHeatmap","survival","survminer",
                   "ConsensusClusterPlus","SNFtool","GSVA","progeny","maftools",
                   "ggplot2","shapper","iml","caret"))


### Directory overview
- data/ → input data (RNA-seq, methylation, mutations, proteomics)  
- figures/ → key result plots (volcano, SNF, KM, Cox, SHAP, oncoplot)  
- reports/ → DOCX/PPTX reports and slides  

---

## 🧾 Citation

If you use this repository, please cite:

> *Bhaskarao Ch (2025).* TNBC Multi-Omics Integration Pipeline. GitHub Repository.  
> Available at: [https://github.com/Baashi27-ai/tnbc---multiomics](https://github.com/Baashi27-ai/tnbc---multiomics)

---

## 👤 Author & License

- *Author:* Bhaskarao Ch (GitHub: [Baashi27-ai](https://github.com/Baashi27-ai))  
- *Email:* bhaskarch.lio6@gmail.com  
- *License:* MIT  

---

## 📌 Milestones
- ✅ Data integration completed  
- ✅ Stable TNBC subtypes identified  
- ✅ Survival-linked pathways validated  
- ✅ Reports & figures compiled  
- 🔄 Next: AI/ML drug discovery expansion
