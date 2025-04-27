# 11_Visualize_Common_BubblePlots.R

# Load required libraries
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("readr", quietly = TRUE)) install.packages("readr")
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("cowplot", quietly = TRUE)) install.packages("cowplot")

library(ggplot2)
library(readr)
library(dplyr)
library(cowplot)

# Set file paths
input_pathway_file <- "../results/Filtered_Enriched_Pathways.csv"
input_go_file <- "../results/Filtered_Enriched_GOprocess.csv"
output_plot_file <- "../results/Plots/Common_BubblePlots_Pathways-GO.tiff"

# Load filtered pathway and GO data
pathways <- read_csv(input_pathway_file)
go <- read_csv(input_go_file)

# Set factor levels based on Final_Score for ordering
pathways$term_description <- factor(pathways$term_description, levels = rev(pathways$term_description))
go$term_description <- factor(go$term_description, levels = rev(go$term_description))

# Create Bubble Plot for Pathways
bubble_pathways <- ggplot(pathways, aes(x = Final_Score, y = term_description)) +
  geom_point(aes(size = hub_gene_count, color = -log10(false_discovery_rate))) +
  scale_color_gradient(low = "lightblue", high = "darkblue") +
  scale_size(range = c(3, 10)) +
  labs(
    title = "A) Enriched Pathways",
    x = "Final Score", y = NULL,
    color = expression(-log[10](FDR)),
    size = "Hub Genes"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
    axis.text.y = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    plot.margin = margin(10, 10, 10, 10)
  ) +
  coord_cartesian(clip = "off")

# Create Bubble Plot for GO Processes
bubble_go <- ggplot(go, aes(x = Final_Score, y = term_description)) +
  geom_point(aes(size = hub_gene_count, color = -log10(false_discovery_rate))) +
  scale_color_gradient(low = "mistyrose", high = "darkred") +
  scale_size(range = c(3, 10)) +
  labs(
    title = "B) Enriched GO Processes",
    x = "Final Score", y = NULL,
    color = expression(-log[10](FDR)),
    size = "Hub Genes"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
    axis.text.y = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    plot.margin = margin(10, 10, 10, 10)
  ) +
  coord_cartesian(clip = "off")

# Combine the two bubble plots
combined_plot <- plot_grid(
  bubble_pathways,
  bubble_go,
  labels = NULL,
  ncol = 2,
  rel_widths = c(1, 1)
)

# Save combined plot
ggsave(
  output_plot_file,
  combined_plot,
  width = 18,
  height = 10,
  units = "in",
  dpi = 800,
  compression = "lzw"
)

cat("✅ Combined bubble plots for Pathways and GO Processes saved successfully! \n")
