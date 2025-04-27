<p align="center">
  <img src="https://img.shields.io/badge/license-CC%20BY%204.0-lightgrey.svg" alt="License: CC BY 4.0">
  <img src="https://img.shields.io/badge/language-R-blue" alt="Language: R">
</p>

Combining WGCNA and DEG Analysis with Prioritization of Enrichment Results for Kidney Allograft Biomarkers

Introduction

This repository contains the complete workflow for integrating Weighted Gene Co-expression Network Analysis (WGCNA) and Differential Expression Analysis (DEGs), followed by prioritization of enrichment results. The goal is to identify biologically meaningful hub genes and key biomarkers involved in chronic kidney allograft rejection.

Project Workflow

WGCNA Analysis: Network construction, module detection, and module merging.

DEG Analysis: Identification of differentially expressed genes between control and rejection samples.

Intersection Analysis: Extraction of overlapping genes between WGCNA modules and DEGs.

Hub Gene Selection: Ranking of hub genes based on network centrality measures.

Prioritization of Enrichment Results: Filtering pathways, GO processes, and diseases based on hub gene involvement and statistical criteria.

Visualization: Final visualizations including bubble plots and disease-gene networks.

Repository Structure

WGCNA_DEGs_validation/
├── code/
│   ├── 01_WGCNA_Analysis.R
│   ├── 02_DEGs_Analysis.R
│   ├── 03_Intersect_Analysis.R
│   ├── 04_Select_TopHubGenes_Gephi.R
│   ├── 05_Select_SharedHubGenes.R
│   ├── 06_Pathways_Filtering.R
│   ├── 07_GO_Filtering.R
│   ├── 08_Disease_Filtering.R
│   └── 09_BubblePlots.R
|
├── data/
│   ├── GSE192444_series_matrix.csv
│   ├── GSE192444Groups.csv
│   ├── familySoft_mini.csv
│   ├── GSE261892_raw_counts_GRCh38.p13_NCBI.csv
│   └── GSE261892DEGs.csv
|
├── results/
│   ├── Plots/
│   │   └── [Final visualizations: bubble plots, disease networks]
│   └── WGCNA/
│       └── [Module gene lists, intermediate analysis results]
|
├── README.md
└── LICENSE

How to Use

Clone this repository.

Open the .R scripts sequentially in your R environment (e.g., RStudio).

Ensure the required R packages are installed.

Follow the workflow step-by-step.

Data Source

GEO dataset: GSE192444

GEO dataset: GSE261892

Note: A minimized version of the familySoft annotation file (familySoft_mini.csv) is provided due to file size limitations. The full version can be downloaded from GSE192444_family.soft.gz.

License

This project is licensed under the Creative Commons Attribution 4.0 International License (CC BY 4.0).

Citation

If you use this repository, please cite it as:

Sarirchi, S. (2025). Combining WGCNA and DEG Analysis with Prioritization of Enrichment Results for Kidney Allograft Biomarkers. GitHub repository. https://github.com/somayehsarirchi/WGCNA_DEGs_validation



