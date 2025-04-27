# 06_Select_TopHubGenes_Gephi.R

# Load necessary libraries
if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("writexl", quietly = TRUE)) install.packages("writexl")

library(readxl)
library(ggplot2)
library(dplyr)
library(writexl)

# Set file paths
input_file <- "../results/GephiResultsCommonGenes.xlsx"
output_path <- "../results/Plots/"

# Load Gephi results for common genes
data <- read_excel(input_file)

# Normalize centrality measures and compute ranking score
data_filtered <- data %>%
  mutate(
    Eigen_norm = scale(`Eigenvector Centrality`),
    Between_norm = scale(`Betweenness Centrality`),
    RankScore = (Eigen_norm + Between_norm) / 2
  )

# Select Top 30 Hub Genes
top_genes <- data_filtered %>%
  arrange(desc(RankScore)) %>%
  slice(1:30)

# Plot Top 30 Hub Genes
ggplot(top_genes, aes(x = reorder(Label, RankScore), y = RankScore)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(title = "Top 30 Hub Genes Based on Combined Centrality",
       x = "Gene", y = "Normalized Centrality Score") +
  theme_minimal(base_size = 14)

ggsave(paste0(output_path, "Top30_HubGenes_Barplot.png"), width = 10, height = 6, dpi = 400)

# Save the Top 30 genes
write_xlsx(top_genes, paste0(output_path, "Top30_HubGenes.xlsx"))
