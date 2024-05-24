library(ggplot2)
library(phyloseq)

# PCoA
ord <- ordinate(ps_nc, "PCoA", "bray")

# Plot
p <- plot_ordination(ps_nc, ord, color = "Month") + 
  geom_point(size = 3, alpha = 0.8) +
  theme_minimal()

# Print plot
print(p)
# Save
ggsave("pcoa_plot_16s.jpeg", plot = p, width = 10, height = 6, dpi = 300)
