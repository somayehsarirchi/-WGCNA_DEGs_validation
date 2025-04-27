<p align="center">
  <img src="https://img.shields.io/badge/license-CC%20BY%204.0-lightgrey.svg" alt="License: CC BY 4.0">
  <img src="https://img.shields.io/badge/language-R-blue" alt="Language: R">
</p>

# Combining WGCNA and DEG Analysis with Prioritization of Enrichment Results for Kidney Allograft Biomarkers

## Introduction

This repository contains the complete workflow for integrating Weighted Gene Co-expression Network Analysis (WGCNA) and Differential Expression Analysis (DEGs), followed by prioritization of enrichment results. The goal is to identify biologically meaningful hub genes and key biomarkers involved in chronic kidney allograft rejection.

## Project Workflow

- **WGCNA Analysis**: Network construction, module detection, and module merging.
- **DEG Analysis**: Identification of differentially expressed genes between control and rejection samples.
- **Intersection Analysis**: Extraction of overlapping genes between WGCNA modules and DEGs.
- **Hub Gene Selection**: Ranking of hub genes based on network centrality measures.
- **Prioritization of Enrichment Results**: Filtering pathways, GO processes, and diseases based on hub gene involvement and statistical criteria.
- **Visualization**: Final visualizations including bubble plots and disease-gene networks.

## Project Workflow Overview

```mermaid
flowchart TD
    A[Start] --> B[WGCNA Analysis: Network construction, module detection, and module merging]
    B --> C[DEG Analysis: Identify differentially expressed genes (DEGs)]
    C --> D[Intersection Analysis: Find overlapping genes between modules and DEGs]
    D --> E[Hub Gene Selection: Rank hub genes by network centrality]
    E --> F[Prioritization of Enrichment Results: Filter pathways, GO terms, diseases]
    F --> G[Visualization: Generate bubble plots and disease-gene networks]
    G --> H[End: Save results in results/ folder]
```

## Repository Structure

```
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
│
├── data/
│   ├── GSE192444_series_matrix.csv
│   ├── GSE192444Groups.csv
│   ├── familySoft_mini.csv
│   ├── GSE261892_raw_counts_GRCh38.p13_NCBI.csv
│   └── GSE261892DEGs.csv
│
├── results/
│   ├── Plots/
│   │   └── [Final visualizations: bubble plots, disease networks]
│   └── WGCNA/
│       └── [Module gene lists, intermediate analysis results]
│
├── README.md
└── LICENSE
```

## How to Use

1. Clone this repository to your local machine.
2. Ensure that R (\u22654.0) and RStudio are installed.
3. Install the required R packages before running the scripts.
4. Open the `.R` scripts sequentially in RStudio:
   - Start with `01_WGCNA_Analysis.R`, then `02_DEGs_Analysis.R`, and so on.
5. Follow the workflow step-by-step. 
   Results (plots, filtered enrichments, hub gene lists) will be saved in the `results/` folder.

## Data Sources

- [GSE192444 - Peripheral blood samples](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE192444)
- [GSE261892 - Biopsy samples](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE261892)

## License

This project is licensed under the [Creative Commons Attribution 4.0 International License (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).  
Attribution is required for reuse.

## Citation

If you use this repository, please cite it as:

> Sarirchi, S. (2025). *Combining WGCNA and DEG Analysis with Prioritization of Enrichment Results for Kidney Allograft Biomarkers*. GitHub repository. [https://github.com/somayehsarirchi/-WGCNA_DEGs_validation](https://github.com/somayehsarirchi/-WGCNA_DEGs_validation)
