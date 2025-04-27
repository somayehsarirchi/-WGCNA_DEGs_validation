# 09_Filter_Common_GOprocess.R

# Load required libraries
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("stringr", quietly = TRUE)) install.packages("stringr")
if (!requireNamespace("purrr", quietly = TRUE)) install.packages("purrr")
if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")

library(dplyr)
library(stringr)
library(purrr)
library(readxl)

# Set file paths
input_go_file <- "../results/Full_Common_GOprocess.csv"
input_hubgene_file <- "../results/Top20_Shared_HubGenes.xlsx"
output_path <- "../results/Filtered_Enriched_GOprocess.csv"

# Load GO process data
data <- read.csv(input_go_file, header = TRUE)

# Remove unnecessary columns if needed
data <- data[, -9]

# Rename columns for clarity
colnames(data) <- c("Category", "term_ID", "term_description", "observed_gene_count",
                    "background_gene_count", "strength", "signal", "false_discovery_rate",
                    "matching_proteins_labels")

# Load shared hub genes
CommonHubGenes <- read_excel(input_hubgene_file)

# Standardize gene names
hub_gene_list <- toupper(trimws(CommonHubGenes$Gene))

# Calculate number of hub genes in each GO term
data <- data %>%
  mutate(hub_gene_count = sapply(matching_proteins_labels, function(x) {
    gene_list <- unlist(strsplit(x, ","))
    gene_list <- toupper(str_trim(gene_list))
    sum(gene_list %in% hub_gene_list)
  }))

# Log-transform signal and strength
data <- data %>%
  mutate(
    log_signal = log1p(signal),
    log_strength = log1p(strength)
  )

# Standardize signal and strength (Z-score)
data <- data %>%
  mutate(
    z_signal = as.vector(scale(log_signal)),
    z_strength = as.vector(scale(log_strength))
  )

# Set thresholds based on distribution
signal_threshold <- quantile(data$z_signal, 0.55)
strength_threshold <- quantile(data$z_strength, 0.55)

# Initial filtering based on signal, strength, FDR, and hub gene count
filtered_data <- data %>%
  filter(z_signal >= signal_threshold &
           z_strength >= strength_threshold &
           false_discovery_rate < 0.01 &
           hub_gene_count >= 3)

# Compute final scores and further filtering
pathway_data <- filtered_data %>%
  mutate(
    log_FDR = -log10(false_discovery_rate),
    penalty = log1p(background_gene_count),
    hub_ratio = hub_gene_count / observed_gene_count,
    Hub_Score = hub_gene_count * 1.5,
    Final_Score = (signal * 2) + (strength * 1.5) +
      (hub_ratio * 2) + log_FDR + Hub_Score - penalty
  ) %>%
  filter(hub_ratio > 0.4) %>%
  arrange(desc(Final_Score))

# Print number of final GO processes selected
cat("Number of filtered GO processes:", nrow(pathway_data), "\n")

# Display top 10 GO processes
print(pathway_data %>%
        select(term_ID, term_description, Final_Score) %>%
        head(10), row.names = FALSE)

# Save the final filtered GO processes
write.csv(pathway_data, output_path, row.names = FALSE)

cat("Filtered GO processes have been saved successfully! ✅\n")
