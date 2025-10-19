# Combining WGCNA and DEG Analysis with Prioritization of Enrichment Results for Kidney Allograft Biomarkers  
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17389220.svg)](https://doi.org/10.5281/zenodo.17389220)
[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-blue.svg)](https://creativecommons.org/licenses/by/4.0/)
![Language](https://img.shields.io/badge/R-100%25-blue)

---

## 🧬 Overview
This repository provides a comprehensive workflow for integrating **Weighted Gene Co-expression Network Analysis (WGCNA)** and **Differential Expression Analysis (DEG)** to identify biologically meaningful hub genes and enriched pathways involved in **chronic kidney allograft rejection**.  
The pipeline supports reproducible identification and validation of immune-related biomarkers through cross-dataset DEG validation and enrichment prioritization.

---

## ⚙️ Project Workflow

| Step | Description |
|------|--------------|
| **1. WGCNA Analysis** | Construct gene co-expression networks, detect and merge modules. |
| **2. DEG Analysis** | Identify differentially expressed genes between control and rejection samples using *limma* or *DESeq2*. |
| **3. Intersection Analysis** | Extract overlapping genes between WGCNA modules and DEGs. |
| **4. Hub Gene Selection** | Rank hub genes based on network centrality metrics. |
| **5. Prioritization of Enrichment Results** | Filter pathways, GO terms, and diseases based on hub gene involvement and statistical significance. |
| **6. Visualization** | Create bubble plots, enrichment maps, and disease–gene networks. |

---

## 📁 Repository Structure

WGCNA_DEGs_validation/
├── code/
│ ├── 01_WGCNA_Analysis.R
│ ├── 02_DEGs_Analysis.R
│ ├── 03_Intersect_Analysis.R
│ ├── 04_Select_TopHubGenes_Gephi.R
│ └── 05_Enrichment_Visualization.R
├── data/
│ ├── expression_matrix.csv
│ ├── sample_metadata.csv
│ └── gene_annotations.txt
├── results/
│ ├── WGCNA_modules/
│ ├── DEGs_results/
│ ├── enrichment/
│ └── hub_gene_networks/
├── LICENSE
├── CITATION.cff
└── README.md


---

## 🚀 How to Use

### 1. Clone the repository
```bash
git clone https://github.com/somayehsarirchi/WGCNA_DEGs_validation.git
cd WGCNA_DEGs_validation
2. Set up your environment

Install R (v4.0 or higher) and RStudio.

3. Install required R packages
install.packages(c("WGCNA", "limma", "DESeq2", "ggplot2", "igraph", "reshape2"))

4. Run the scripts sequentially
source("code/01_WGCNA_Analysis.R")
source("code/02_DEGs_Analysis.R")
source("code/03_Intersect_Analysis.R")
source("code/04_Select_TopHubGenes_Gephi.R")

5. Review your results

Outputs are automatically saved in the results/ folder, organized by analysis type.

🧠 Data Sources

GSE192444 – Peripheral blood and biopsy samples

GSE261892 – Biopsy samples

🪶 License

This project is licensed under the Creative Commons Attribution 4.0 International License (CC BY 4.0)
.
You are free to share and adapt the workflow with proper attribution.

📚 Citation

Sarirchi, S. (2025). Combining WGCNA and DEG Analysis with Prioritization of Enrichment Results for Kidney Allograft Biomarkers.
Zenodo. https://doi.org/10.5281/zenodo.17389220

💬 Contact

For questions or collaboration inquiries:
📧 s.sarirchi@gmail.com
GitHub:https://github.com/somayehsarirchi

🧩 Keywords

Bioinformatics • WGCNA • DEG • Network Biology • Kidney Allograft Rejection • Enrichment Analysis • Hub Genes • Systems Immunology

⭐ If you find this workflow useful, please consider starring the repository!




