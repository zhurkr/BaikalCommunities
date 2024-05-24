library(tidyverse)
library(phyloseq); packageVersion("phyloseq")
library(ggplot2); packageVersion("ggplot2")

desired_order_april <- c("V1UI-0-FL",
                         "V1UI-5-FL",
                         "V2UI-0-FL",
                         "V2UI-5-FL",
                         "V2UI-10-FL",
                         "V2UI-30-FL",
                         "V3UI-0-FL",
                         "V3UI-5-FL",
                         "V3UI-10-FL",
                         "V3UI-30-FL",
                         "V1UI-0-PA",
                         "V1UI-5-PA",
                         "V2UI-0-PA",
                         "V2UI-5-PA",
                         "V2UI-10-PA",
                         "V2UI-30-PA",
                         "V3UI-0-PA",
                         "V3UI-10-PA",
                         "V3UI-30-PA")
desired_order_july <- c("V1PL-0-FL",
                        "V1PL-3-FL",
                        "V1PL-7-FL",
                        "V2PL-0-FL",
                        "V2PL-5-FL",
                        "V2PL-10-FL",
                        "V2PL-30-FL",
                        "V3PL-0-FL",
                        "V3PL-5-FL",
                        "V3PL-10-FL",
                        "V3PL-30-FL",
                        "V1PL-0-PA",
                        "V1PL-3-PA",
                        "V1PL-7-PA",
                        "V2PL-0-PA",
                        "V2PL-5-PA",
                        "V2PL-10-PA",
                        "V2PL-30-PA",
                        "V3PL-0-PA",
                        "V3PL-5-PA",
                        "V3PL-10-PA",
                        "V3PL-30-PA")
ps_nc_Class <- ps_nc

# Get the taxonomic information
tax_info <- tax_table(ps_nc_Class)

# Get the Class column
Class_info <- tax_info[,"Class"]

# Sum the counts for each Class
Class_counts <- tapply(taxa_sums(ps_nc_Class), Class_info, sum)

top12_Class <- names(sort(Class_counts, decreasing=TRUE))[1:12]

# Get the ASVs that belong to the top 12 Class
top12_ASVs <- rownames(tax_info)[tax_info[,"Class"] %in% top12_Class]

# Prune the taxa based on these ASVs
ps_nc_Class.top12_Class <- prune_taxa(top12_ASVs, ps_nc_Class)

ps_nc_Class.top12_Class_arpil <- subset_samples(ps_nc_Class.top12_Class, Month == "April")
ps_nc_Class.top12_Class_july <- subset_samples(ps_nc_Class.top12_Class, Month == "July")

df_Class_april <- psmelt(ps_nc_Class.top12_Class_arpil)
df_Class_july <- psmelt(ps_nc_Class.top12_Class_july)

df_Class_april$ID <- factor(df_Class_april$ID, levels = desired_order_april)
df_Class_july$ID <- factor(df_Class_july$ID, levels = desired_order_july)

Class_colors <- c(
  "Flavobacteriia" = "#1f77b4", 
  "Betaproteobacteria" = "#ff7f0e", 
  "Actinobacteria" = "#2ca02c", 
  "Alphaproteobacteria" = "#d62728", 
  "Gammaproteobacteria" = "#9467bd", 
  "Acidimicrobiia" = "#8c564b", 
  "Cytophagia" = "#e377c2", 
  "Cyanobacteria" = "#7f7f7f", 
  "Planctomycetacia" = "#bcbd22", 
  "Verrucomicrobiae" = "#1a55FF",
  "Chitinophagia" = "#17becf",
  "Subdivision3" = "#ff1493",
  "Nitrosopumilales" = "#ffaadd"
)

# Class barplot 
relative_abundance_Class_top12_april <- ggplot(df_Class_april, aes(x = ID, y = Abundance, fill = Class)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Class_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the FL and bacterial Class (top12) in April", 
       x = "samples", 
       y = "abundance") +
  theme(
    plot.title = element_text(hjust = 0.5, size = 15), 
    axis.title.x = element_text(size = 15), 
    axis.title.y = element_text(size = 15), 
    axis.text.x = element_text(angle = 45, hjust = 1, size = 15), # Объединяем настройки для текста оси X
    legend.text = element_text(size = 10),
    theme_minimal() 
  )

print(relative_abundance_Class_top12_april)
ggsave("relative_abundance_Class_top12_april_275.jpeg", plot = relative_abundance_Class_top12_april, width = 10, height = 6, dpi = 300)

relative_abundance_Class_top12_july <- ggplot(df_Class_july, aes(x = ID, y = Abundance, fill = Class)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Class_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the PA bacterial Class (top12) in July", 
       x = "Samples", 
       y = "Abundance") +
  theme_minimal() + 
  theme(
    plot.title = element_text(hjust = 0.5, size = 15), 
    axis.title.x = element_text(size = 15), 
    axis.title.y = element_text(size = 15), 
    axis.text.x = element_text(angle = 45, hjust = 1, size = 15), # Объединяем настройки для текста оси X
    legend.text = element_text(size = 10)
  )
print(relative_abundance_Class_top12_july)
ggsave("relative_abundance_Class_top12_july_275.jpeg", plot = relative_abundance_Class_top12_july, width = 10, height = 6, dpi = 300)
