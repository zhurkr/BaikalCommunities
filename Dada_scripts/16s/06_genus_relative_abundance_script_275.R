library(tidyverse)
library(phyloseq); packageVersion("phyloseq")
library(ggplot2); packageVersion("ggplot2")

desired_order_april_FL <- c("V1UI-0-FL",
                            "V1UI-5-FL",
                            "V2UI-0-FL",
                            "V2UI-5-FL",
                            "V2UI-10-FL",
                            "V2UI-30-FL",
                            "V3UI-0-FL",
                            "V3UI-5-FL",
                            "V3UI-10-FL",
                            "V3UI-30-FL")
desired_order_april_PA <- c("V1UI-0-PA",
                            "V1UI-5-PA",
                            "V2UI-0-PA",
                            "V2UI-5-PA",
                            "V2UI-10-PA",
                            "V2UI-30-PA",
                            "V3UI-0-PA",
                            "V3UI-10-PA",
                            "V3UI-30-PA")
desired_order_july_FL <- c("V1PL-0-FL",
                           "V1PL-3-FL",
                           "V1PL-7-FL",
                           "V2PL-0-FL",
                           "V2PL-5-FL",
                           "V2PL-10-FL",
                           "V2PL-30-FL",
                           "V3PL-0-FL",
                           "V3PL-5-FL",
                           "V3PL-10-FL",
                           "V3PL-30-FL")
desired_order_july_PA <- c("V1PL-0-PA",
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

ps_nc_Genus <- ps_nc

# Get the taxonomic information
Genus_tax_info <- tax_table(ps_nc_Genus)

# Get the Genus column
Genus_info <- Genus_tax_info[,"Genus"]

ps_nc_Genus <- transform_sample_counts(ps_nc_Genus, function(x) x / sum(x))

# Sum the counts for each Genus
Genus_counts <- tapply(taxa_sums(ps_nc_Genus), Genus_info, sum)

top12_Genus <- names(sort(Genus_counts, decreasing=TRUE))[1:12]

# Get the ASVs that belong to the top 12 Genus
top12_ASVs <- rownames(Genus_tax_info)[Genus_tax_info[,"Genus"] %in% top12_Genus]

# Prune the taxa based on these ASVs
ps_nc_Genus.top12_Genus <- prune_taxa(top12_ASVs, ps_nc_Genus)

ps_nc_Genus.top12_Genus_arpil <- subset_samples(ps_nc_Genus.top12_Genus, Month == "April")
ps_nc_Genus.top12_Genus_arpil_FL <- subset_samples(ps_nc_Genus.top12_Genus_arpil, Lifestyle == "Free-Living")
ps_nc_Genus.top12_Genus_arpil_PA <- subset_samples(ps_nc_Genus.top12_Genus_arpil, Lifestyle == "Particle attached")

ps_nc_Genus.top12_Genus_july <- subset_samples(ps_nc_Genus.top12_Genus, Month == "July")
ps_nc_Genus.top12_Genus_july_FL <- subset_samples(ps_nc_Genus.top12_Genus_july, Lifestyle == "Free-Living")
ps_nc_Genus.top12_Genus_july_PA <- subset_samples(ps_nc_Genus.top12_Genus_july, Lifestyle == "Particle attached")

df_Genus_april_FL <- psmelt(ps_nc_Genus.top12_Genus_arpil_FL)
df_Genus_april_PA <- psmelt(ps_nc_Genus.top12_Genus_arpil_PA)

df_Genus_july_FL <- psmelt(ps_nc_Genus.top12_Genus_july_FL)
df_Genus_july_PA <- psmelt(ps_nc_Genus.top12_Genus_july_PA)

df_Genus_april_FL$ID <- factor(df_Genus_april_FL$ID, levels = desired_order_april_FL)
df_Genus_april_PA$ID <- factor(df_Genus_april_PA$ID, levels = desired_order_april_PA)

df_Genus_july_FL$ID <- factor(df_Genus_july_FL$ID, levels = desired_order_july_FL)
df_Genus_july_PA$ID <- factor(df_Genus_july_PA$ID, levels = desired_order_july_PA)

Genus_colors <- c(
  "Flavobacterium" = "#1f77b4",
  "Nitrosopumilus" = "#ff7f0e",
  "GpIIa" = "#2ca02c",
  "Luteolibacter" = "#d62728",
  "Acinetobacter" = "#e377c2",
  "Subdivision3_genera_incertae_sedis" = "#9467bd",
  "Spartobacteria_genera_incertae_sedis" = "#8c564b",
  "Legionella" = "#7f7f7f",
  "Methylobacter" = "#bcbd22",
  "Fluviicola" = "#17becf",
  "Arcicella" = "#1a55FF",
  "Emticicia" = "#ff1493",
  "Desertimonas"= "#2c0a2c",
  "Rhodoferax" = "#c23000",
  "Lishizhenia" = "#4f9",
  "Armatimonas/Armatimonadetes_gp1" = "#019",
  "Limnohabitans" = "#23fa09",
  "Gimesia" = "#faf123"
)


# Genus barplot 
relative_abundance_Genus_top12_april_FL <- ggplot(df_Genus_april_FL, aes(x = ID, y = Abundance, fill = Genus)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Genus_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the FL and bacterial Genus (top12) in April", 
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

print(relative_abundance_Genus_top12_april_FL)
ggsave("relative_abundance_Genus_top12_april_FL_275.jpeg", plot = relative_abundance_Genus_top12_april_FL, width = 10, height = 12, dpi = 300)

relative_abundance_Genus_top12_april_PA <- ggplot(df_Genus_april_PA, aes(x = ID, y = Abundance, fill = Genus)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Genus_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the FL and bacterial Genus (top12) in April", 
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

print(relative_abundance_Genus_top12_april_PA)
ggsave("relative_abundance_Genus_top12_april_PA_275.jpeg", plot = relative_abundance_Genus_top12_april_PA, width = 10, height = 12, dpi = 300)


relative_abundance_Genus_top12_july_FL <- ggplot(df_Genus_july_FL, aes(x = ID, y = Abundance, fill = Genus)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Genus_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the FL and bacterial Genus (top12) in july", 
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

print(relative_abundance_Genus_top12_july_FL)
ggsave("relative_abundance_Genus_top12_july_FL_275.jpeg", plot = relative_abundance_Genus_top12_july_FL, width = 10, height = 12, dpi = 300)

relative_abundance_Genus_top12_july_PA <- ggplot(df_Genus_july_PA, aes(x = ID, y = Abundance, fill = Genus)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Genus_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the FL and bacterial Genus (top12) in July", 
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

print(relative_abundance_Genus_top12_july_PA)
ggsave("relative_abundance_Genus_top12_July_PA_275.jpeg", plot = relative_abundance_Genus_top12_july_PA, width = 10, height = 12, dpi = 300)

relative_abundance_Genus_top12_july_FL <- ggplot(df_Genus_july_FL, aes(x = ID, y = Abundance, fill = Genus)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Genus_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the FL and bacterial Genus (top12) in July", 
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

print(relative_abundance_Genus_top12_july_FL)
ggsave("relative_abundance_Genus_top12_July_FL_275.jpeg", plot = relative_abundance_Genus_top12_july_FL, width = 10, height = 12, dpi = 300)



