require(phyloseq)
require(ggplot2)

p <- plot_richness(ps_na, x = "Month", measures=c("ACE", "Shannon", "Simpson"))

boxplots <- p + geom_boxplot(aes(colour = Month, fill=Month)) + 
  labs(title = "18S_275", x = "Month", y = "Alpha diversity measure") + 
  theme_minimal() +
  geom_point(position = position_jitter(width = 0.2), size = 1.5, alpha = 0.5) +
  theme(plot.title = element_text(hjust = 0.5, size = 15), axis.title.x = element_text(size = 20), axis.title.y = element_text(size = 20), axis.text.x = element_text(size = 20))
ggsave("18s_boxplots_275.jpeg", plot = boxplots, width = 10, height = 6, dpi = 300)
