<p align="center">
  <img src="https://img.shields.io/badge/license-CC%20BY%204.0-lightgrey.svg" alt="License: CC BY 4.0">
  <img src="https://img.shields.io/badge/language-R-blue" alt="Language: R">
</p>

# WGCNA-based Integrated Analysis of Gene Expression Data

## Introduction

This repository contains the complete workflow for a weighted gene co-expression network analysis (WGCNA) integrated with differential expression analysis (DEGs), hub gene identification, and enrichment filtering (pathways, GO processes, diseases).

The goal was to identify biologically meaningful hub genes and key pathways by combining WGCNA modules with DEGs from independent datasets, followed by comprehensive downstream analysis and visualization.

## Project Workflow

- **WGCNA Analysis**: Network construction, module detection, and merging similar modules.
- **Differential Expression Analysis (DEGs)**: Identification of DEGs between control and rejection samples.
- **Intersection Analysis**: Extraction of genes overlapping between WGCNA modules and DEGs.
- **Selection of Top Hub Genes**: Ranking hub genes based on network centrality scores.
- **Filtering Enrichment Results**: Selection of significant pathways, GO processes, and diseases based on multiple filtering criteria.
- **Visualization**: Final visual outputs including combined bubble plots and disease-gene networks.

## Repository Structure

WGCNA_DEGs_validation/ │ ├── code/ │ ├── 01_WGCNA_Analysis.R │ ├── 02_DEGs_Analysis.R │ ├── 03_Intersect_Analysis.R │ ├── 04_Select_TopHubGenes_Gephi.R │ ├── 05_Select_SharedHubGenes.R │ ├── 06_Pathways_Filtering.R │ ├── 07_GO_Filtering.R │ └── 08_Disease_Filtering.R │ ├── data/ │ ├── GSE192444_series_matrix.csv │ ├── GSE192444Groups.csv │ └── familySoft_mini.csv │ ├── results/ │ ├── Plots/ │ │ ├── [Final visualizations like bubble plots and networks] │ └── WGCNA/ │ ├── [Module gene lists, intermediate results, DEG results, etc.] │ ├── README.md └── LICENSE


## How to Use

1. Clone this repository to your local machine.
2. Open the `.R` scripts sequentially in your R environment (e.g., RStudio).
3. Ensure required R packages are installed.
4. Follow the project workflow step-by-step.


## Data Source

- GEO dataset: [GSE192444](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE192444)
- GEO dataset: [GSE261892](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE261892)

## License

This project is licensed under the [Creative Commons Attribution 4.0 International License (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

## Citation

If you use this repository, please cite it as:

> Sarirchi, S. (2025). *WGCNA-based Integrated Analysis of Gene Expression Data*. GitHub repository. [https://github.com/somayehsarirchi/-WGCNA_DEGs_validation](https://github.com/somayehsarirchi/-WGCNA_DEGs_validation)

---
