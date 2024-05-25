library(phyloseq)
library(ggplot2)

# Transform data for PCoA
ps.prop <- transform_sample_counts(ps_na, function(otu) otu/sum(otu))

# PCoA
ord.pcoa <- ordinate(ps.prop, method="PCoA", distance="bray")

# Visualize PCoA
plot_ordination(ps.prop, ord.pcoa, color="id", title="PCoA of Microeukaryotic Communities")

# Visualize PCoA and titles Month
pcoa_plot <- plot_ordination(ps.prop, ord.pcoa, color="Month", title="PCoA of Microeukaryotic Communities")
pcoa_plot_132 <- pcoa_plot + geom_text(aes(label=sample_data(ps.prop)$id), size=3, vjust=1, hjust=1)
ggsave("pcoa_plot_v132_month.jpeg", plot = pcoa_plot_132, width = 10, height = 6, dpi = 300)
# Visualize PCoA and titles id
pcoa_plot <- plot_ordination(ps.prop, ord.pcoa, color="id", title="PCoA of Microeukaryotic Communities")
pcoa_plot_132 <- pcoa_plot + geom_text(aes(label=sample_data(ps.prop)$Month), size=3, vjust=1, hjust=1)
ggsave("pcoa_plot_v132_id.jpeg", plot = pcoa_plot_132, width = 10, height = 6, dpi = 300)
