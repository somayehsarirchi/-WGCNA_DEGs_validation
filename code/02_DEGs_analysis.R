# 02_DEGs_analysis.R

# Load necessary libraries
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")

packages <- c("DESeq2", "clusterProfiler", "ReactomePA", "DOSE", "org.Hs.eg.db",
              "ggplot2", "VennDiagram", "dplyr", "readr", "AnnotationDbi")

needed_packages <- packages[!(packages %in% installed.packages()[,"Package"])]
if (length(needed_packages)) BiocManager::install(needed_packages)

lapply(packages, library, character.only = TRUE)

# Set file paths
input_path <- "../data/"
output_path <- "../results/"

# Load raw count data
raw_counts <- read.csv(paste0(input_path, "GSE261892_raw_counts_GRCh38.p13_NCBI.csv"),
                       header = TRUE, row.names = 1, stringsAsFactors = FALSE)
annotation_data <- read.csv(paste0(input_path, "GSE261892Human.GRCh38.p13.annot.csv"),
                            header = TRUE, stringsAsFactors = FALSE)

# Remove unnecessary columns
raw_counts <- raw_counts[, -1]

# Define sample groups
Control_names <- c("GSM8153578","GSM8153580","GSM8153581","GSM8153582","GSM8153583","GSM8153584","GSM8153585",
                   "GSM8153589","GSM8153590","GSM8153592","GSM8153594","GSM8153595","GSM8153596","GSM8153597",
                   "GSM8153599","GSM8153600","GSM8153601","GSM8153604","GSM8153605","GSM8153606","GSM8153607",
                   "GSM8153608","GSM8153609","GSM8153610","GSM8153611","GSM8153612","GSM8153613","GSM8153615",
                   "GSM8153616","GSM8153617","GSM8153618","GSM8153619","GSM8153620","GSM8153621","GSM8153623",
                   "GSM8153625","GSM8153627","GSM8153629","GSM8153630","GSM8153631","GSM8153632","GSM8153634",
                   "GSM8153636","GSM8153637","GSM8153638","GSM8153640","GSM8153641","GSM8153642","GSM8153645",
                   "GSM8153647","GSM8153648","GSM8153650","GSM8153651","GSM8153652","GSM8153654","GSM8153656",
                   "GSM8153657","GSM8153660","GSM8153661","GSM8153663","GSM8153664","GSM8153665","GSM8153666",
                   "GSM8153668","GSM8153669","GSM8153671","GSM8153672","GSM8153673","GSM8153675","GSM8153676",
                   "GSM8153678","GSM8153680","GSM8153681","GSM8153682","GSM8153683","GSM8153684","GSM8153685",
                   "GSM8153686","GSM8153687","GSM8153688","GSM8153690","GSM8153691","GSM8153692","GSM8153694",
                   "GSM8153695","GSM8153693","GSM8153697","GSM8153698")

Rejection_names <- c("GSM8153577","GSM8153579","GSM8153586","GSM8153587","GSM8153588","GSM8153591","GSM8153593",
                     "GSM8153598","GSM8153602","GSM8153603","GSM8153614","GSM8153622","GSM8153624","GSM8153626",
                     "GSM8153628","GSM8153633","GSM8153635","GSM8153639","GSM8153643","GSM8153644","GSM8153646",
                     "GSM8153649","GSM8153653","GSM8153655","GSM8153658","GSM8153659","GSM8153662","GSM8153667",
                     "GSM8153670","GSM8153674","GSM8153677","GSM8153679","GSM8153689","GSM8153693","GSM8153699")

control_indices <- which(colnames(raw_counts) %in% control_samples)
rejection_indices <- which(colnames(raw_counts) %in% rejection_samples)

selected_samples <- c(control_indices, rejection_indices)
data_selected <- raw_counts[, selected_samples]

# Filter low-expressed genes
low_expression_cutoff <- quantile(rowSums(data_selected), 0.10)
data_selected <- data_selected[rowSums(data_selected) > low_expression_cutoff, ]

# Filter low-variance genes
sd_data <- apply(data_selected, 1, sd)
cutoff_sd <- quantile(sd_data, 0.25)
data_selected <- data_selected[sd_data > cutoff_sd, ]

# Perform DESeq2 analysis
conditions <- factor(c(rep("Control", length(control_indices)), rep("Rejection", length(rejection_indices))))
colData <- data.frame(row.names = colnames(data_selected), condition = conditions)

dds <- DESeqDataSetFromMatrix(countData = data_selected, colData = colData, design = ~ condition)
CountsNorm <- DESeq(dds)
DEG_result <- as.data.frame(results(CountsNorm))

# Filter significant DEGs
DEG_result <- DEG_result[which(DEG_result$padj < 0.05 & abs(DEG_result$log2FoldChange) > 1), ]

# Merge annotation
DEG_result$GeneID <- rownames(DEG_result)
DEG_result <- merge(DEG_result, annotation_data[, c("GeneID", "Symbol", "Description", "EnsemblGeneID")],
                    by = "GeneID", all.x = TRUE)

# Save DEGs result
write.csv(DEG_result, paste0(output_path, "GSE261892DEGs.csv"), row.names = FALSE)


