# 07_Select_SharedHubGenes.R

# Load necessary libraries
if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("scales", quietly = TRUE)) install.packages("scales")
if (!requireNamespace("writexl", quietly = TRUE)) install.packages("writexl")

library(readxl)
library(ggplot2)
library(dplyr)
library(scales)
library(writexl)

# Set file paths
file_wgcna <- "../results/GephiResultsWGCNA.xlsx"
file_common <- "../results/GephiResultsCommonGenes.xlsx"
output_path <- "../results/Plots/"

# Load Gephi results for WGCNA and Common Genes
df1 <- read_excel(file_wgcna) %>%
  rename(Gene = Label) %>%
  select(Gene, `Eigenvector Centrality`, `Betweenness Centrality`) %>%
  rename(Eigen_WGCNA = `Eigenvector Centrality`,
         Between_WGCNA = `Betweenness Centrality`)

df2 <- read_excel(file_common) %>%
  rename(Gene = Label) %>%
  select(Gene, `Eigenvector Centrality`, `Betweenness Centrality`) %>%
  rename(Eigen_Common = `Eigenvector Centrality`,
         Between_Common = `Betweenness Centrality`)

# Find shared genes and compute composite score
shared_genes <- inner_join(df1, df2, by = "Gene") %>%
  mutate(
    Mean_Eigen = (Eigen_WGCNA + Eigen_Common) / 2,
    Mean_Between = (Between_WGCNA + Between_Common) / 2,
    CompositeScore = (Mean_Eigen * 0.6) + (Mean_Between * 0.4)
  ) %>%
  arrange(desc(CompositeScore)) %>%
  slice_head(n = 20)

# Save the shared hub genes
write_xlsx(shared_genes, paste0(output_path, "Top20_Shared_HubGenes.xlsx"))

# Plot Top 20 Shared Hub Genes
ggplot(shared_genes, aes(x = reorder(Gene, CompositeScore), y = CompositeScore)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(title = "Top 20 Shared Hub Genes Ranked by Composite Centrality Score",
       x = "Gene",
       y = "Composite Centrality Score") +
  theme_minimal(base_size = 13)

ggsave(paste0(output_path, "Top20_Shared_HubGenes_Barplot.png"), width = 10, height = 6, dpi = 400)

print(shared_genes)
