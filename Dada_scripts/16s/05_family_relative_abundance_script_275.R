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

ps_nc_Family <- ps_nc

# Get the taxonomic information
Family_tax_info <- tax_table(ps_nc_Family)

# Get the Family column
Family_info <- Family_tax_info[,"Family"]

ps_nc_Family <- transform_sample_counts(ps_nc_Family, function(x) x / sum(x))

# Sum the counts for each Family
Family_counts <- tapply(taxa_sums(ps_nc_Family), Family_info, sum)

top12_Family <- names(sort(Family_counts, decreasing=TRUE))[1:12]

# Get the ASVs that belong to the top 12 Family
top12_ASVs <- rownames(Family_tax_info)[Family_tax_info[,"Family"] %in% top12_Family]

# Prune the taxa based on these ASVs
ps_nc_Family.top12_Family <- prune_taxa(top12_ASVs, ps_nc_Family)

ps_nc_Family.top12_Family_arpil <- subset_samples(ps_nc_Family.top12_Family, Month == "April")
ps_nc_Family.top12_Family_arpil_FL <- subset_samples(ps_nc_Family.top12_Family_arpil, Lifestyle == "Free-Living")
ps_nc_Family.top12_Family_arpil_PA <- subset_samples(ps_nc_Family.top12_Family_arpil, Lifestyle == "Particle attached")

ps_nc_Family.top12_Family_july <- subset_samples(ps_nc_Family.top12_Family, Month == "July")
ps_nc_Family.top12_Family_july_FL <- subset_samples(ps_nc_Family.top12_Family_july, Lifestyle == "Free-Living")
ps_nc_Family.top12_Family_july_PA <- subset_samples(ps_nc_Family.top12_Family_july, Lifestyle == "Particle attached")

df_Family_april_FL <- psmelt(ps_nc_Family.top12_Family_arpil_FL)
df_Family_april_PA <- psmelt(ps_nc_Family.top12_Family_arpil_PA)

df_Family_july_FL <- psmelt(ps_nc_Family.top12_Family_july_FL)
df_Family_july_PA <- psmelt(ps_nc_Family.top12_Family_july_PA)

df_Family_april_FL$ID <- factor(df_Family_april_FL$ID, levels = desired_order_april_FL)
df_Family_april_PA$ID <- factor(df_Family_april_PA$ID, levels = desired_order_april_PA)

df_Family_july_FL$ID <- factor(df_Family_july_FL$ID, levels = desired_order_july_FL)
df_Family_july_PA$ID <- factor(df_Family_july_PA$ID, levels = desired_order_july_PA)

Family_colors <- c(
  "Flavobacteriaceae" = "#1f77b4",
  "Comamonadaceae" = "#ff7f0e",
  "Nitrosopumilus" = "#2ca02c",
  "GpIIa" = "#000028",
  "Candidatus_Pelagibacter" = "#94ddbd",
  "Cytophagaceae" = "#8c564b",
  "Verrucomicrobiaceae" = "#bcbd22",
  "Intrasporangiaceae" = "#0f7f70",
  "Chitinophagaceae" = "#e377c2",
  "Cryomorphaceae" = "#17becf",
  "Ilumatobacteraceae" = "#8B572A",
  "Cytophagaceae" = "#0a5500"
)


# Family barplot 
relative_abundance_Family_top12_april_FL <- ggplot(df_Family_april_FL, aes(x = ID, y = Abundance, fill = Family)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Family_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the FL and bacterial Family (top12) in April", 
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

print(relative_abundance_Family_top12_april_FL)
ggsave("relative_abundance_Family_top12_april_FL_275.jpeg", plot = relative_abundance_Family_top12_april_FL, width = 10, height = 12, dpi = 300)

relative_abundance_Family_top12_april_PA <- ggplot(df_Family_april_PA, aes(x = ID, y = Abundance, fill = Family)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Family_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the FL and bacterial Family (top12) in April", 
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

print(relative_abundance_Family_top12_april_PA)
ggsave("relative_abundance_Family_top12_april_PA_275.jpeg", plot = relative_abundance_Family_top12_april_PA, width = 10, height = 12, dpi = 300)


relative_abundance_Family_top12_july_FL <- ggplot(df_Family_july_FL, aes(x = ID, y = Abundance, fill = Family)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Family_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the FL and bacterial Family (top12) in july", 
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

print(relative_abundance_Family_top12_july_FL)
ggsave("relative_abundance_Family_top12_july_FL_275.jpeg", plot = relative_abundance_Family_top12_july_FL, width = 10, height = 12, dpi = 300)

relative_abundance_Family_top12_july_PA <- ggplot(df_Family_july_PA, aes(x = ID, y = Abundance, fill = Family)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Family_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the FL and bacterial Family (top12) in July", 
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

print(relative_abundance_Family_top12_july_PA)
ggsave("relative_abundance_Family_top12_July_PA_275.jpeg", plot = relative_abundance_Family_top12_july_PA, width = 10, height = 12, dpi = 300)

relative_abundance_Family_top12_july_FL <- ggplot(df_Family_july_FL, aes(x = ID, y = Abundance, fill = Family)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Family_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the FL and bacterial Family (top12) in July", 
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

print(relative_abundance_Family_top12_july_FL)
ggsave("relative_abundance_Family_top12_July_FL_275.jpeg", plot = relative_abundance_Family_top12_july_FL, width = 10, height = 12, dpi = 300)



