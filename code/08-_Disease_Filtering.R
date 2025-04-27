# 10_Filter_Common_Diseases.R

# Load required libraries
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("stringr", quietly = TRUE)) install.packages("stringr")
if (!requireNamespace("purrr", quietly = TRUE)) install.packages("purrr")
if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("igraph", quietly = TRUE)) install.packages("igraph")
if (!requireNamespace("ggraph", quietly = TRUE)) install.packages("ggraph")
if (!requireNamespace("tidyr", quietly = TRUE)) install.packages("tidyr")
if (!requireNamespace("patchwork", quietly = TRUE)) install.packages("patchwork")

library(dplyr)
library(stringr)
library(purrr)
library(readxl)
library(ggplot2)
library(igraph)
library(ggraph)
library(tidyr)
library(patchwork)

# Set file paths
input_disease_file <- "../results/Unique_Shared_Diseases_Info.csv"
input_hubgene_file <- "../results/Top20_Shared_HubGenes.xlsx"
output_disease_file <- "../results/Filtered_Enriched_Diseases.csv"
output_plot_file <- "../results/Plots/Focused_Bubble_Network_Diseases.png"

# Load disease data and hub genes
raw_disease_data <- read.csv(input_disease_file, header = TRUE, stringsAsFactors = FALSE)
CommonHubGenes <- read_excel(input_hubgene_file)

hub_gene_list <- toupper(trimws(CommonHubGenes$Gene))

# Rename columns and clean data
raw_disease_data <- raw_disease_data %>%
  rename(
    p_value = P_value,
    q_value_Bonferroni = FDR_Bonferroni,
    q_value_FDR_BH = FDR_BH,
    q_value_FDR_BY = FDR_BY,
    hit_count_query = Query_Hits,
    hit_count_genome = Genome_Hits,
    matching_proteins_labels = Hits
  )

raw_disease_data$matching_proteins_labels[is.na(raw_disease_data$matching_proteins_labels)] <- ""

# Calculate hub gene count per disease
filtered_disease <- raw_disease_data %>%
  mutate(hub_gene_count = sapply(matching_proteins_labels, function(x) {
    genes <- unlist(str_split(x, ","))
    genes <- str_trim(toupper(genes))
    sum(genes %in% hub_gene_list)
  }))

# Apply filtering criteria
filtered_disease <- filtered_disease %>%
  filter(
    q_value_FDR_BH < 0.01,
    q_value_Bonferroni < 0.01,
    hub_gene_count >= 3,
    hit_count_genome >= 10
  ) %>%
  mutate(
    hit_ratio = hit_count_query / hit_count_genome,
    log_FDR = -log10(q_value_FDR_BH + 1e-10),
    log_p_value = -log10(p_value + 1e-10),
    hub_ratio = hub_gene_count / hit_count_query,
    Hub_Score = hub_gene_count * 1.5,
    Final_Score = (hit_ratio * 3) + (log_FDR * 2) + (hub_ratio * 2) + Hub_Score,
    Name = Name %>%
      iconv(to = "ASCII//TRANSLIT") %>%
      str_replace_all("[\u00A0\u200B]", " ") %>%
      str_replace_all("\\s+", " ") %>%
      str_replace_all("\\(.*?\\)", "") %>%
      str_replace_all(",.*", "") %>%
      str_trim()
  ) %>%
  arrange(desc(Final_Score))

# Save filtered diseases
write.csv(filtered_disease, output_disease_file, row.names = FALSE)
cat("✅ Number of filtered diseases:", nrow(filtered_disease), "\n")

# Select top 20 diseases for visualization
top_bubble <- filtered_disease %>%
  distinct(Name, .keep_all = TRUE) %>%
  slice_max(Final_Score, n = 20)

top_disease_names <- top_bubble$Name

# Create Bubble Plot
bubble_plot <- ggplot(top_bubble, aes(x = reorder(Name, Final_Score), y = Final_Score)) +
  geom_point(aes(size = hub_gene_count, color = log_FDR), alpha = 0.9) +
  coord_flip() +
  scale_color_gradient(low = "lightpink", high = "deeppink4") +
  labs(
    title = "Top 20 Enriched Diseases",
    x = "Disease",
    y = "Final Score",
    size = "Hub Gene Count",
    color = "-log10(FDR)"
  ) +
  theme_minimal(base_size = 14) +
  theme(plot.margin = margin(0, 0, 0, 0))

# Create Disease–Gene Network
graph_edges <- filtered_disease %>%
  filter(Name %in% top_disease_names) %>%
  select(Name, matching_proteins_labels) %>%
  filter(matching_proteins_labels != "") %>%
  mutate(genes = str_split(matching_proteins_labels, ",")) %>%
  unnest(genes) %>%
  mutate(genes = str_trim(toupper(genes))) %>%
  filter(genes %in% hub_gene_list) %>%
  select(from = Name, to = genes)

graph_filtered <- graph_from_data_frame(graph_edges, directed = FALSE)
V(graph_filtered)$type <- ifelse(V(graph_filtered)$name %in% top_disease_names, "Disease", "Gene")

# Create Network Plot
set.seed(123)
network_plot <- ggraph(graph_filtered, layout = "fr") +
  geom_edge_link(alpha = 0.25, color = "#b0c4de", edge_width = 0.6, edge_curvature = 0.2) +
  geom_node_point(aes(color = type), size = 5) +
  geom_node_text(aes(label = name), repel = TRUE, size = 3.2, family = "sans") +
  scale_color_manual(
    values = c("Disease" = "#E41A1C", "Gene" = "#377EB8"),
    guide = "none"
  ) +
  theme_void() +
  labs(title = "Focused Disease–Gene Network") +
  theme(plot.margin = margin(0, 0, 0, 0))

# Combine and save the plots
combined_plot <- bubble_plot + network_plot + plot_layout(widths = c(1.2, 2))

ggsave(output_plot_file, combined_plot, width = 16, height = 8, dpi = 300)

cat("✅ Disease bubble plot and network saved successfully! \n")