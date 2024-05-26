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

ps_nc_phylum <- ps_nc

# Get the taxonomic information
phylum_tax_info <- tax_table(ps_nc_phylum)

# Get the Phylum column
phylum_info <- phylum_tax_info[,"Phylum"]

ps_nc_phylum <- transform_sample_counts(ps_nc_phylum, function(x) x / sum(x))

# Sum the counts for each Phylum
phylum_counts <- tapply(taxa_sums(ps_nc_phylum), phylum_info, sum)

top12_phylum <- names(sort(phylum_counts, decreasing=TRUE))[1:12]

# Get the ASVs that belong to the top 12 phylum
top12_ASVs <- rownames(phylum_tax_info)[phylum_tax_info[,"Phylum"] %in% top12_phylum]

# Prune the taxa based on these ASVs
ps_nc_phylum.top12_phylum <- prune_taxa(top12_ASVs, ps_nc_phylum)

ps_nc_phylum.top12_phylum_arpil <- subset_samples(ps_nc_phylum.top12_phylum, Month == "April")
ps_nc_phylum.top12_phylum_arpil_FL <- subset_samples(ps_nc_phylum.top12_phylum_arpil, Lifestyle == "Free-Living")
ps_nc_phylum.top12_phylum_arpil_PA <- subset_samples(ps_nc_phylum.top12_phylum_arpil, Lifestyle == "Particle attached")

ps_nc_phylum.top12_phylum_july <- subset_samples(ps_nc_phylum.top12_phylum, Month == "July")
ps_nc_phylum.top12_phylum_july_FL <- subset_samples(ps_nc_phylum.top12_phylum_july, Lifestyle == "Free-Living")
ps_nc_phylum.top12_phylum_july_PA <- subset_samples(ps_nc_phylum.top12_phylum_july, Lifestyle == "Particle attached")

df_phylum_april_FL <- psmelt(ps_nc_phylum.top12_phylum_arpil_FL)
df_phylum_april_PA <- psmelt(ps_nc_phylum.top12_phylum_arpil_PA)

df_phylum_july_FL <- psmelt(ps_nc_phylum.top12_phylum_july_FL)
df_phylum_july_PA <- psmelt(ps_nc_phylum.top12_phylum_july_PA)

df_phylum_april_FL$ID <- factor(df_phylum_april_FL$ID, levels = desired_order_april_FL)
df_phylum_april_PA$ID <- factor(df_phylum_april_PA$ID, levels = desired_order_april_PA)

df_phylum_july_FL$ID <- factor(df_phylum_july_FL$ID, levels = desired_order_july_FL)
df_phylum_july_PA$ID <- factor(df_phylum_july_PA$ID, levels = desired_order_july_PA)

phylum_colors <- c(
  "Bacteroidetes" = "#1f77b4", 
  "Proteobacteria" = "#ff7f0e", 
  "Actinobacteria" = "#2ca02c", 
  "Verrucomicrobia" = "#d62728", 
  "Cyanobacteria" = "#9467bd", 
  "Thaumarchaeota" = "#8c564b", 
  "Planctomycetes" = "#e377c2", 
  "Acidobacteria" = "#7f7f7f", 
  "Firmicutes" = "#bcbd22", 
  "Nitrospirae" = "#17becf",
  "Armatimonadetes" = "#1a55FF",
  "Chloroflexi"  = "#1f1403"
)


# Phylum barplot 
relative_abundance_phylum_top12_april_FL <- ggplot(df_phylum_april_FL, aes(x = ID, y = Abundance, fill = Phylum)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = phylum_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the FL and bacterial phylum (top12) in April", 
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

print(relative_abundance_phylum_top12_april_FL)
ggsave("relative_abundance_phylum_top12_april_FL_275.jpeg", plot = relative_abundance_phylum_top12_april_FL, width = 10, height = 12, dpi = 300)

relative_abundance_phylum_top12_april_PA <- ggplot(df_phylum_april_PA, aes(x = ID, y = Abundance, fill = Phylum)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = phylum_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the FL and bacterial phylum (top12) in April", 
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

print(relative_abundance_phylum_top12_april_PA)
ggsave("relative_abundance_phylum_top12_april_PA_275.jpeg", plot = relative_abundance_phylum_top12_april_PA, width = 10, height = 12, dpi = 300)


relative_abundance_phylum_top12_july_FL <- ggplot(df_phylum_july_FL, aes(x = ID, y = Abundance, fill = Phylum)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = phylum_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the FL and bacterial phylum (top12) in july", 
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

print(relative_abundance_phylum_top12_july_FL)
ggsave("relative_abundance_phylum_top12_july_FL_275.jpeg", plot = relative_abundance_phylum_top12_july_FL, width = 10, height = 12, dpi = 300)

relative_abundance_phylum_top12_july_PA <- ggplot(df_phylum_july_PA, aes(x = ID, y = Abundance, fill = Phylum)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = phylum_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the FL and bacterial phylum (top12) in July", 
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

print(relative_abundance_phylum_top12_july_PA)
ggsave("relative_abundance_phylum_top12_July_PA_275.jpeg", plot = relative_abundance_phylum_top12_july_PA, width = 10, height = 12, dpi = 300)

relative_abundance_phylum_top12_july_FL <- ggplot(df_phylum_july_FL, aes(x = ID, y = Abundance, fill = Phylum)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = phylum_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the FL and bacterial phylum (top12) in July", 
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

print(relative_abundance_phylum_top12_july_FL)
ggsave("relative_abundance_phylum_top12_July_FL_275.jpeg", plot = relative_abundance_phylum_top12_july_FL, width = 10, height = 12, dpi = 300)
