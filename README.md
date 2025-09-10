# TNBC Multi-Omics (Bhaskararao Ch)

End-to-end analysis of Triple-Negative Breast Cancer (TNBC) using RNA-seq, DNA methylation, mutations/TMB, and proteomics.  
Multi-omics are integrated via Similarity Network Fusion (SNF) + consensus clustering, validated by survival (KM/Cox) and pathway enrichment (GO/GSVA/PROGENy).  
Model explainability is provided with SHAP.  

*Author:* Bhaskararao Ch (GitHub: Baashi27-ai)  
*License:* MIT  

---

## 🔑 Highlights
- *Integration:* SNF + consensus → stable TNBC subtypes  
- *Biology:* GO/Reactome enrichment; GSVA panels; PROGENy TF activity  
- *Outcomes:* Kaplan–Meier & age-adjusted Cox confirm prognostic separation  
- *Explainability:* SHAP summaries + feature prep scripts  

---

## 📂 Repo Layout
```plaintext
tnbc-multiomics/
│── data/              # Sample input data (sanitized)
│── env/               # Environment reproducibility (YAML, sessionInfo)
│── reports/           # Key reports (slides, quick summary, M1)
│── results/           # Outputs: plots, tables, enrichment, survival
│── src/               # Scripts: RNA-seq, methylation, proteomics, SNF
│── deliverables/      # Final curated figures & presentations
│── .gitignore         # Ignore rules for large/data artifacts
│── LICENSE            # MIT License
│── README.md          # Project overview (this file)

## Key Figures

<p align="center">
  <img src="figures/SNF_UMAP.png" alt="SNF UMAP" width="45%"/>
  <img src="figures/KM_SNF_clusters.png" alt="Kaplan–Meier by SNF clusters" width="45%"/>
</p>

<p align="center">
  <img src="figures/volcano_DESeq2_TNBC_vs_NonTNBC.png" alt="RNA-seq Volcano" width="45%"/>
  <img src="figures/volcano_Methylation_TNBC_vs_NonTNBC.png" alt="Methylation Volcano" width="45%"/>
</p>

<p align="center">
  <img src="figures/venn_deg_dmp.png" alt="DEG–DMP overlap" width="45%"/>
  <img src="figures/TMB_hist_TNBC.png" alt="Tumor Mutational Burden" width="45%"/>
</p>

<p align="center">
  <img src="figures/cox_forest_by_cluster.png" alt="Cox Forest by cluster" width="45%"/>
  <img src="figures/GO_BP_HyperDown_top15.png" alt="GO BP HyperDown" width="45%"/>
</p>

<p align="center">
  <img src="figures/GO_BP_HypoUp_top15.png" alt="GO BP HypoUp" width="45%"/>
  <img src="figures/shap_summary.png" alt="SHAP summary" width="45%"/>
</p>

<p align="center">
  <img src="figures/oncoplot_TNBC_top20.png" alt="Oncoplot top 20" width="60%"/>
</p>


