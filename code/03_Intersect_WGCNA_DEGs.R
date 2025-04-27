# 03_Intersect_WGCNA_DEGs.R

# Load necessary libraries
if (!requireNamespace("ggvenn", quietly = TRUE)) install.packages("ggvenn")
if (!requireNamespace("cowplot", quietly = TRUE)) install.packages("cowplot")

library(ggvenn)
library(ggplot2)
library(cowplot)

# Set file paths
input_path <- "../results/"

# Load pink module genes and DEGs
pink_cluster_genes <- read.csv(paste0(input_path, "Module_pink_Genes_Clean.csv"), header = TRUE)
deg_genes <- read.csv(paste0(input_path, "GSE261892DEGs.csv"), header = TRUE)

pink_gene_list <- unique(pink_cluster_genes$GeneSymbol)
deg_gene_list <- unique(deg_genes$Symbol)

# Find common genes
common_genes <- intersect(na.omit(pink_gene_list), na.omit(deg_gene_list))
write.csv(common_genes, paste0(input_path, "Common_Genes.csv"), row.names = FALSE)

# Create Venn diagram
gene_lists <- list(
  "WGCNA pink Module" = pink_gene_list,
  "DEGs" = deg_gene_list
)

venn_plot <- ggvenn(
  gene_lists,
  fill_color = c("pink", "skyblue"),
  stroke_size = 0.5,
  set_name_size = 5,
  text_size = 5
)

# Create bar plot
overlap_count <- length(common_genes)
only_pink <- length(setdiff(pink_gene_list, deg_gene_list))
only_deg <- length(setdiff(deg_gene_list, pink_gene_list))

bar_data <- data.frame(
  Category = c("WGCNA only", "DEGs only", "Shared"),
  Count = c(only_pink, only_deg, overlap_count)
)

bar_plot <- ggplot(bar_data, aes(x = Category, y = Count, fill = Category)) +
  geom_bar(stat = "identity") +
  theme_minimal(base_size = 14) +
  scale_fill_manual(values = c("skyblue", "lightgreen", "pink")) +
  labs(y = "Number of Genes", x = "") +
  theme(legend.position = "none")

# Combine and save plots
combined_plot <- plot_grid(venn_plot, bar_plot, ncol = 2, rel_widths = c(1, 1))

save_plot("../results/Plots/Venn_Bar_Combined.pdf", combined_plot, base_height = 5, base_width = 10)
save_plot("../results/Plots/Venn_Bar_Combined.png", combined_plot, base_height = 5, base_width = 10, dpi = 300)

print(combined_plot)
