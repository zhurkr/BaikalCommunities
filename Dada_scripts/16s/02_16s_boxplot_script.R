require(phyloseq)
require(ggplot2)

ps_nc_FL <- subset_samples(ps_16s_nc, Lifestyle == "Free-Living")
ps_nc_PA <- subset_samples(ps_16_nc, Lifestyle == "Particle attached")

# ACE, Shannon, Simpson, Chao1
## FL
p <- plot_richness(ps_nc_FL, x = "Month", measures=c("ACE", "Shannon", "Simpson"))

boxplots_FL <- p + geom_boxplot(aes(colour = Month, fill = Month)) + 
  labs(title = "16S_275_FL", x = "Month", y = "Alpha diversity measure") + 
  theme_minimal() +
  geom_point(position = position_jitter(width = 0.2), size = 1.5, alpha = 0.5) +
  theme(plot.title = element_text(hjust = 0.5, size = 15), axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13), axis.text.x = element_text(size = 13),
        legend.position = "none") 
ggsave("boxplots_275_FL.jpeg", plot = boxplots_FL, width = 10, height = 6, dpi = 300)

## PA
p <- plot_richness(ps_nc_PA, x = "Month", measures=c("ACE", "Shannon", "Simpson"))

boxplots_PA <- p + geom_boxplot(aes(colour = Month, fill = Month)) + 
  labs(title = "16S_275_PA", x = "Month", y = "Alpha diversity measure") + 
  theme_minimal() +
  geom_point(position = position_jitter(width = 0.2), size = 1.5, alpha = 0.5) +
  theme(plot.title = element_text(hjust = 0.5, size = 15), axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13), axis.text.x = element_text(size = 13),
        legend.position = "none")      
ggsave("boxplots_275_PA.jpeg", plot = boxplots_PA, width = 10, height = 6, dpi = 300)




