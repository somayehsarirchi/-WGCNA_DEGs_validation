# 01_WGCNA_analysis.R 


# CONFIGURATION SECTION


# Load necessary libraries
if (!requireNamespace("WGCNA", quietly = TRUE)) install.packages("WGCNA")
if (!requireNamespace("readr", quietly = TRUE)) install.packages("readr")
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("limma", quietly = TRUE)) install.packages("limma")

library(WGCNA)
library(readr)
library(dplyr)
library(limma)

# Set global options
options(stringsAsFactors = FALSE)
allowWGCNAThreads()

# File paths
input_expression_file <- "../data/GSE192444_series_matrix.csv"
input_annotation_file <- "../data/familySoft_mini.csv"
input_trait_file <- "../data/GSE192444Groups.csv"
output_dir <- "../results/WGCNA/"

# Verbose levels
verbose_pick_soft_threshold <- 5
verbose_merge_close_modules <- 3

# Other parameters
variance_threshold <- 0.1
merge_cut_height <- 0.55
min_module_size <- 50

# Create output directory if it doesn't exist
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)


#  STEP 1: Load and Prepare Data


# Read expression data and annotation file
expression_data <- read_csv(input_expression_file)
annotation_data <- read_csv(input_annotation_file)

# Process annotation to create unique gene names
unique_gene_names <- sapply(strsplit(as.character(annotation_data[, 15]), "///"), function(x) {
  if (length(x) > 0) {
    return(trimws(x[1]))
  } else {
    return(NA)
  }
})
unique_gene_names[is.na(unique_gene_names)] <- "Unnamed"
unique_gene_names <- make.unique(unique_gene_names)

# Apply gene names to expression data
rownames(expression_data) <- unique_gene_names
expression_data <- expression_data[, -1]

# Filter genes based on variance
filtered_data <- expression_data[apply(expression_data, 1, var) > variance_threshold, ]

# Read trait data
trait_data <- read_csv(input_trait_file)
trait_data$Population <- as.factor(trait_data$Population)
trait_data$cfDNA <- as.numeric(trait_data$cfDNA)
trait_data$DSA <- as.numeric(trait_data$DSA)

# Remove NA samples and align IDs
trait_data <- trait_data[!is.na(trait_data$DSA), ]
trait_data <- trait_data[order(trait_data$IDs), ]
filtered_data <- filtered_data[, trait_data$IDs]

# Transpose expression matrix
expression_data_t <- t(filtered_data)


# STEP 2: Network Construction and Module Detection


# Pick soft-thresholding power
powers <- c(1:20)
soft_threshold <- pickSoftThreshold(expression_data_t, powerVector = powers, verbose = verbose_pick_soft_threshold)
selected_power <- which(soft_threshold$fitIndices$SFT.R.sq >= 0.9)[1]

# Build adjacency and TOM
adjacency_matrix <- adjacency(expression_data_t, power = selected_power)
TOM <- TOMsimilarity(adjacency_matrix)
dissTOM <- 1 - TOM

# Hierarchical clustering of genes
gene_tree <- hclust(as.dist(dissTOM), method = "average")

# Dynamic tree cut for module detection
dynamic_modules <- cutreeDynamic(dendro = gene_tree, distM = dissTOM, deepSplit = 2, pamRespectsDendro = FALSE, minClusterSize = min_module_size)
module_colors <- labels2colors(dynamic_modules)

# Calculate eigengenes and merge similar modules
ME_list <- moduleEigengenes(expression_data_t, colors = module_colors)
MEs <- ME_list$eigengenes
merged_modules <- mergeCloseModules(expression_data_t, module_colors, cutHeight = merge_cut_height, verbose = verbose_merge_close_modules)


# STEP 3: Module–Trait Relationships


# Calculate correlation
myModules <- orderMEs(moduleEigengenes(expression_data_t, merged_modules$colors)$eigengenes)
trait_matrix <- trait_data[, c("Population", "cfDNA", "DSA")]
cor_modules_traits <- cor(myModules, trait_matrix, use = "pairwise.complete.obs")
pvalue_modules_traits <- corPvalueStudent(cor_modules_traits, nrow(expression_data_t))

# Heatmap of module-trait relationships
text_matrix <- paste(signif(cor_modules_traits, 2), "\n(", signif(pvalue_modules_traits, 2), ")", sep = "")
dim(text_matrix) <- dim(cor_modules_traits)
dev.off()
labeledHeatmap(Matrix = cor_modules_traits, xLabels = colnames(cor_modules_traits), yLabels = rownames(cor_modules_traits), colorLabels = FALSE, colors = blueWhiteRed(100), textMatrix = text_matrix, setStdMargins = FALSE, cex.text = 0.5, zlim = c(-1,1))


#  STEP 4: Save Module Genes


module_colors_unique <- unique(merged_modules$colors)
module_colors_unique <- module_colors_unique[module_colors_unique != "grey"]

for (color in module_colors_unique) {
  cat("Processing module:", color, "\n")
  
  gene_names <- colnames(expression_data_t)[merged_modules$colors == color]
  
  output_df <- data.frame(GeneSymbol = gene_names)
  
  # Clean gene symbols
  output_df$GeneSymbol <- sub("\\..*$", "", output_df$GeneSymbol)
  output_df$GeneSymbol <- gsub("[^A-Za-z0-9]", "", output_df$GeneSymbol)
  output_df <- output_df[!duplicated(output_df$GeneSymbol), ]
  output_df <- output_df[!(output_df$GeneSymbol %in% c("---", "Unnamed") | is.na(output_df$GeneSymbol) | output_df$GeneSymbol == ""), ]
  
  # Save cleaned file
  clean_file <- paste0(output_dir, "Module_", color, "_Genes_Clean.csv")
  write.csv(output_df, clean_file, row.names = FALSE)
}

cat("\n✅ WGCNA analysis and module gene extraction completed successfully!\n")
