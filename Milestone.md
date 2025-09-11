# TNBC Multi-Omics — Project Milestones

Owner: *Bhaskararao Ch* (GitHub: *Baashi27-ai*)  
Repo: https://github.com/Baashi27-ai/tnbc---multiomics

---

## 📆 Timeline (high-level)
- *M1 — Repo foundation*: structure, README, figures, env files, license
- *M2 — Reproducible setup*: conda env (env/environment.yml), env/sessionInfo.txt
- *M3 — Analysis scripts*: preprocessing, SNF, clustering, survival, enrichment, SHAP
- *M4 — Results & reports*: figures, tables, DOCX/PPTX
- *M5 — Validation*: external GEO sets; sensitivity checks
- *M6 — Packaging*: release, Zenodo DOI, CITATION

---

## ✅ Milestone checklist

### M1. Repo foundation
- [x] Folder layout: data/, figures/, results/, reports/, src/, env/
- [x] Project README with example figures
- [x] .gitignore for R + data + logs
- [x] *MIT LICENSE*

### M2. Reproducible setup
- [x] env/environment.yml (R 4.3 + bioc)
- [x] env/sessionInfo.txt snapshot
- [ ] Test conda env create -f env/environment.yml
- [ ] Document any platform notes (Windows/Linux)

### M3. Analysis scripts (src/)
- [x] run_all.R (pipeline orchestrator)
- [x] prep_data.R (QC/normalization; RNA/methylation/proteomics/mutations)
- [x] snf_consensus.R (SNF + consensus clustering)
- [x] survival_analysis.R (KM/Cox)
- [x] pathway_panels.R (GO/Reactome GSVA, PROGENy)
- [x] shap_summary.R (explainability)
- [ ] geo_validate.R (external validation)
- [ ] project_housekeeping.R (paths/IO helpers)

### M4. Results & reports
- [x] Figures pushed (figures/…png)
- [x] Report docs (reports/TNBC_Report.docx, TNBC_QuickSummary.docx)
- [x] Slides (reports/TNBC_slides.pptx)
- [ ] results/tables/ CSV exports with model outputs
- [ ] Frozen checkpoints for reproducibility notes

### M5. Validation
- [ ] GEO cohorts selected; accession IDs listed in README
- [ ] Reproduce clustering signatures on external data
- [ ] Compare survival separation & pathway concordance

### M6. Packaging & citation
- [x] Git tag *v1.0*
- [ ] GitHub Release *v1.1* (adds environment + docs polish)
- [ ] Zenodo DOI (connect repo → Zenodo; mint DOI)
- [ ] CITATION.cff added to repo root

---

## 📦 Deliverables matrix

| Area | Artifact | Path |
|---|---|---|
| Setup | Conda environment | env/environment.yml |
| Repro snapshot | R session info | env/sessionInfo.txt |
| Pipeline | Orchestrator | run_all.R |
| Analysis | Scripts | src/*.R |
| Figures | PNGs showcased in README | figures/*.png |
| Reports | DOCX / PPTX deliverables | reports/* |
| Results | Tables / checkpoints | results/ |

---

## 🔁 Changelog (brief)
- *v1.0* — Initial public release: structure, figures, reports, scripts, README, LICENSE  
- *v1.1* — Environment & docs polish: environment.yml, sessionInfo.txt, milestones, improved README badges  
- *v1.2 (planned)* — GEO validation + full results tables

---

## 🧰 How to reproduce (short)
```bash
# 1) create environment
conda env create -f env/environment.yml
conda activate tnbc_multiomics

# 2) place data in data/  (see data/README.md)
# 3) run the pipeline
Rscript run_all.R
