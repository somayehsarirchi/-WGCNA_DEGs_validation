# 🧬 Combining WGCNA and DEG Analysis with Prioritization of Enrichment Results for Kidney Allograft Biomarkers  
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17389220.svg)](https://doi.org/10.5281/zenodo.17389220)
[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-blue.svg)](https://creativecommons.org/licenses/by/4.0/)
![Language](https://img.shields.io/badge/R-100%25-blue)

---
## 📄 Commercial Case Study

➡ [Download Case Study PDF](case_study/CaseStudy2_Immune_Hub_Gene_Discovery_Transcriptomic_Networks.pdf)

## 🧬 Overview  
This repository provides a complete and reproducible workflow integrating **Weighted Gene Co-expression Network Analysis (WGCNA)** and **Differential Expression Analysis (DEG)** to identify immune-related **hub genes**, enriched pathways, and disease associations involved in **chronic kidney allograft rejection**.

The pipeline enables:  
✔ Cross-dataset DEG validation  
✔ Prioritization of functional enrichment results  
✔ Visualization of immune-related biomarker signatures  
✔ Generation of publication-ready plots  

---

## 🔍 Key Results (Preview)

### **1. Soft-thresholding Power**
![Soft thresholding power](results/Plots/Figure_S1.tif)

### **2. Module Dendrogram**
![Module dendrogram](results/Plots/Figure_1.tif)

### **3. Module–Trait Heatmap**
![Module–trait heatmap](results/Plots/Figure_2.tif)

### **4. Enriched Pathways (Bubble Plot)**
![Enriched Pathways plot](results/Plots/Figure_7.tif)

### **5. Enriched Diseases Plot**
![Enriched Diseases plot](results/Plots/Figure_8.tif)

### **6. Protein–Protein Interaction (PPI) Network**
![PPI network](results/Plots/Figure_5.tif)

---

## ⚙️ Project Workflow

| Step | Description |
|------|--------------|
| **1. WGCNA Analysis** | Construct gene co-expression networks, detect & merge modules. |
| **2. DEG Analysis** | Identify differentially expressed genes using *limma* or *DESeq2*. |
| **3. Intersection Analysis** | Extract overlapping genes between WGCNA modules and DEGs. |
| **4. Hub Gene Selection** | Rank hub genes using multiple centrality metrics. |
| **5. Enrichment Prioritization** | Filter pathways & disease terms based on hub-gene relevance. |
| **6. Visualization** | Produce bubble plots, enrichment maps, and PPI networks. |

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

### **1. Clone the repository**
```bash
git clone https://github.com/somayehsarirchi/WGCNA_DEGs_validation.git
cd WGCNA_DEGs_validation

2. Set up your environment

    Install R ≥ 4.0 and RStudio.

3. Install required packages

install.packages(c("WGCNA", "limma", "DESeq2", "ggplot2", "igraph", "reshape2"))

4. Run the analysis pipeline

source("code/01_WGCNA_Analysis.R")
source("code/02_DEGs_Analysis.R")
source("code/03_Intersect_Analysis.R")
source("code/04_Select_TopHubGenes_Gephi.R")
source("code/05_Enrichment_Visualization.R")

5. View the results

All outputs are saved automatically under the results/ directory.
🧠 Data Sources

    GSE192444 – Peripheral blood & biopsy samples

    GSE261892 – Biopsy samples

🪪 License

This project is licensed under the Creative Commons Attribution 4.0 International (CC BY 4.0).
You may use and modify the workflow with proper attribution.
📚 Citation

Sarirchi, S. (2025). Combining WGCNA and DEG Analysis with Prioritization of Enrichment Results for Kidney Allograft Biomarkers.
Zenodo. https://doi.org/10.5281/zenodo.17389220
💬 Contact

📧 Email: s.sarirchi@gmail.com

🔗 GitHub: https://github.com/somayehsarirchi

🔗 LinkedIn: https://linkedin.com/in/somayeh-sarirchi-9b2b59171
🧩 Keywords

Bioinformatics • Transcriptomics • WGCNA • DEG • Network Biology • Kidney Allograft Rejection • Enrichment Analysis • Hub Genes • Systems Immunology

⭐ If you find this workflow useful, please consider starring the repository!



