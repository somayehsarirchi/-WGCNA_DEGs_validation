WGCNA-based Integrated Analysis of Gene Expression Data

 <p align="center">
  <img src="https://img.shields.io/badge/license-CC%20BY%204.0-lightgrey.svg" alt="License: CC BY 4.0">
  <img src="https://img.shields.io/badge/language-R-blue" alt="Language: R">
  <img src="https://img.shields.io/github/last-commit/somayehsarirchi/-WGCNA_DEGs_validation" alt="Last Commit">
</p>

 Introduction

This repository contains the complete workflow for a weighted gene co-expression network analysis (WGCNA) integrated with differential expression analysis (DEGs), hub gene identification, and enrichment filtering (pathways, GO processes, diseases).

The goal was to identify biologically meaningful hub genes and key pathways by combining WGCNA modules with DEGs from independent datasets, followed by comprehensive downstream analysis and visualization.

 Project Workflow

WGCNA Analysis: Network construction, module detection, and merging similar modules.

Differential Expression Analysis (DEGs): Identification of DEGs between control and rejection samples.

Intersection Analysis: Extraction of genes overlapping between WGCNA modules and DEGs.

Selection of Top Hub Genes: Ranking hub genes based on network centrality scores.

Filtering Enrichment Results: Selection of significant pathways, GO processes, and diseases based on multiple filtering criteria.

Visualization: Final visual outputs including combined bubble plots and disease-gene networks.

 Repository Structure

WGCNA_DEGs_validation/
├── code/
│    ├── 01_WGCNA_analysis.R
│    ├── 02_DEGs_analysis.R
│    ├── 03_Intersect_Analysis.R
│    ├── 04_Select_TopHubGenes_Gephi.R
│    ├── 05_Select_SharedHubGenes.R
│    ├── 06_Pathways_Filtering.R
│    ├── 07_GO_Filtering.R
│    ├── 08_Disease_Filtering.R
│    ├── 09_BubblePlots.R
├── data/
│    ├── GSE192444_series_matrix.csv
│    ├── GSE192444Groups.csv
│    ├── familySoft_mini.csv
├── results/
│    ├── Plots/
│    │    ├── (Final visualizations like bubble plots and networks)
│    ├── WGCNA/
│    │    ├── (Module gene lists, WGCNA intermediate results)
│    ├── (Other result files: DEG results, Intersected genes, Filtered pathways, GO, diseases)
├── README.md
├── .gitignore

 File Descriptions

01_WGCNA_analysis.R: Constructs the weighted co-expression network and detects modules.

02_DEGs_analysis.R: Performs differential expression analysis using DESeq2.

03_Intersect_Analysis.R: Intersects WGCNA module genes with DEGs.

04_Select_TopHubGenes_Gephi.R: Selects top 30 hub genes from network centrality metrics.

05_Select_SharedHubGenes.R: Identifies top 20 shared hub genes between WGCNA and DEG networks.

06_Pathways_Filtering.R: Filters enriched pathways based on hub gene involvement, signal, and FDR.

07_GO_Filtering.R: Filters enriched GO biological processes similarly.

08_Disease_Filtering.R: Filters enriched diseases and generates combined visual plots.

09_BubblePlots_Final.R: Creates final combined bubble plots for pathways and GO processes.

 Data

GSE192444_series_matrix.csv: Gene expression matrix (processed version).

GSE192444Groups.csv: Sample grouping and trait information.

familySoft_mini.csv: A small subset of the full annotation file used for probe-to-gene mapping.

 Important Note:The full familySoft.csv (~158 MB) was too large for GitHub upload.This repository includes a smaller version (familySoft_mini.csv) for testing purposes.For complete mapping and production analyses, users are encouraged to download the full annotation file from the GEO database:Download GSE192444_family.soft.gzor contact the project owner.

 How to Run the Scripts

Each R script is modular and self-contained.Recommended execution order:

# From within the code/ directory
Rscript 01_WGCNA_analysis.R
Rscript 02_DEGs_analysis.R
Rscript 03_Intersect_Analysis.R
Rscript 04_Select_TopHubGenes_Gephi.R
Rscript 05_Select_SharedHubGenes.R
Rscript 06_Pathways_Filtering.R
Rscript 07_GO_Filtering.R
Rscript 08_Disease_Filtering.R
Rscript 09_BubblePlots.R

Make sure the data/ folder contains all required input files before running.

 Output and Visualization

Filtered results (Pathways, GO processes, Diseases) are saved under /results/.

Visual plots:

Combined Pathway & GO Bubble Plot: Common_BubblePlots_Final.tiff

Focused Disease–Gene Network and Bubble Plot: Focused_Bubble_Network_Final.png

 Note

This repository is under active development and optimization pending manuscript submission.

Feel free to open an issue or contact for any questions regarding the workflow or analysis details!

=======
# -WGCNA_DEGs_validation
WGCNA analysis combined with DEG validation across datasets
>>>>>>> 78cb5258aa928b8d777bce76b1b2a1b7ac042030
