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

Project Workflow Overview

flowchart TD
    A[Start: WGCNA Analysis] --> B[DEG Analysis]
    B --> C[Intersection Analysis]
    C --> D[Hub Gene Selection]
    D --> E[Prioritization of Enrichment Results]
    E --> F[Visualization]
    F --> G[Save results in results/ folder]

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
├── data/
│   ├── GSE192444_series_matrix.csv
│   ├── GSE192444Groups.csv
│   ├── familySoft_mini.csv
│   ├── GSE261892_raw_counts_GRCh38.p13_NCBI.csv
│   └── GSE261892DEGs.csv
├── results/
│   ├── Plots/
│   │   └── [Final visualizations: bubble plots, disease networks]
│   └── WGCNA/
│       └── [Module gene lists, intermediate analysis results]
├── README.md
└── LICENSE

How to Use

Clone this repository to your local machine.

Ensure that R (>=4.0) and RStudio are installed.

Install the required R packages before running the scripts.

Open the .R scripts sequentially in RStudio:

Start with 01_WGCNA_Analysis.R, then 02_DEGs_Analysis.R, and so on.

Follow the workflow step-by-step.Results (plots, filtered enrichments, hub gene lists) will be saved in the results/ folder.

Data Sources

GSE192444 - Peripheral blood and Biopsy samples

GSE261892 - Biopsy samples

License

This project is licensed under the Creative Commons Attribution 4.0 International License (CC BY 4.0).Attribution is required for reuse.

Citation

If you use this repository, please cite it as:

Sarirchi, S. (2025). Combining WGCNA and DEG Analysis with Prioritization of Enrichment Results for Kidney Allograft Biomarkers. GitHub repository. https://github.com/somayehsarirchi/-WGCNA_DEGs_validation

=======
Combining WGCNA and DEG Analysis with Prioritization of Enrichment Results for Kidney Allograft Biomarkers

Introduction

This repository provides a comprehensive workflow for integrating Weighted Gene Co-expression Network Analysis (WGCNA) and Differential Expression Analysis (DEGs), followed by prioritization of enrichment results. The goal is to identify biologically meaningful hub genes and key biomarkers involved in chronic kidney allograft rejection.

Project Workflow

WGCNA Analysis: Construct gene co-expression networks, detect and merge modules.

DEG Analysis: Identify differentially expressed genes between control and rejection samples.

Intersection Analysis: Extract overlapping genes between WGCNA modules and DEGs.

Hub Gene Selection: Rank hub genes based on network centrality metrics.

Prioritization of Enrichment Results: Filter pathways, GO terms, and diseases based on hub gene involvement and statistical significance.

Visualization: Create bubble plots and disease-gene networks for the final results.

Workflow Overview

flowchart TD
    A[Start] --> B[WGCNA Analysis: Network construction, module detection, and module merging]
    B --> C[DEG Analysis: Identify differentially expressed genes (DEGs)]
    C --> D[Intersection Analysis: Find overlapping genes between WGCNA modules and DEGs]
    D --> E[Hub Gene Selection: Rank genes by network centrality]
    E --> F[Prioritization of Enrichment Results: Filter pathways, GO terms, diseases]
    F --> G[Visualization: Generate bubble plots and disease-gene networks]
    G --> H[End: Save results in the results/ folder]

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

How to Use

Clone the repository:

git clone https://github.com/somayehsarirchi/WGCNA_DEGs_validation.git

Set up your environment:

Install R (version 4.0 or higher) and RStudio.

Install the required R packages:

install.packages(c("WGCNA", "limma", "DESeq2", "ggplot2", "igraph", "reshape2"))

Run the scripts sequentially:

Start with 01_WGCNA_Analysis.R, then continue through to 09_BubblePlots.R.

Review your results:

Outputs will be saved in the results/ folder, organized by analysis type.

Data Sources

GSE192444 - Peripheral blood and Biopsy samples

GSE261892 - Biopsy samples

License

This project is licensed under the Creative Commons Attribution 4.0 International License (CC BY 4.0).

Citation

If you use this repository, please cite it as:

Sarirchi, S. (2025). Combining WGCNA and DEG Analysis with Prioritization of Enrichment Results for Kidney Allograft Biomarkers. GitHub repository. https://github.com/somayehsarirchi/WGCNA_DEGs_validation

>>>>>>> 8ae57a91956aa24d60f840d5ac54b7bc70418e5d
