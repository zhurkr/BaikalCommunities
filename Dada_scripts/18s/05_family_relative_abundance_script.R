library(phyloseq)
library(ggplot2)

ps_na_Family <- ps_na

ps_na_april <- subset_samples(ps_na_Family, Month == "April")
ps_na_july <- subset_samples(ps_na_Family, Month == "July")

# Get the taxonomic information
tax_info_april <- tax_table(ps_na_april)
tax_info_july <- tax_table(ps_na_july)

# Get the Family column
Family_info_april <- tax_info_april[,"Family"]
Family_info_july <- tax_info_july[,"Family"]

# Sum the counts for each Family
Family_counts_april <- tapply(taxa_sums(ps_na_april), Family_info_april, sum)
Family_counts_july <- tapply(taxa_sums(ps_na_july), Family_info_july, sum)

top12_Family_april <- names(sort(Family_info_april, decreasing=TRUE))[1:12]
top12_Family_july <- names(sort(Family_info_july, decreasing=TRUE))[1:12]

# Prune the taxa based on these ASVs
ps_na.top12_phyla_april <- prune_taxa(top12_Family_april, ps_na_april)
ps_na.top12_phyla_july <- prune_taxa(top12_Family_july, ps_na_july)

df_phyla_april <- psmelt(ps_na.top12_phyla_april)
df_phyla_july <- psmelt(ps_na.top12_phyla_july)

df_phyla_april$id <- factor(df_phyla_april$id, levels = desired_order_april)
df_phyla_july$id <- factor(df_phyla_july$id, levels = desired_order_july)

# Задаем палитру
Family_colors <- c(
  "Flavobacteriaceae" = "#1f77b4",
  "Comamonadaceae" = "#ff7f0e",
  "Nitrosopumilaceae" = "#2ca02c",
  "Family_II" = "#d62728",
  "Methylococcaceae" = "#9467bd",
  "Cytophagaceae" = "#8c564b",
  "Chitinophagaceae" = "#e377c2",
  "Rhodobacteraceae" = "#7f7f7f",
  "Verrucomicrobiaceae" = "#bcbd22",
  "Cryomorphaceae" = "#17becf",
  "Moraxellaceae" = "#1a55FF",
  "Ilumatobacteraceae" = "#8B572A"
)

# Построение графика Family
relative_abundance_Family_top12_april <- ggplot(df_phyla_april, aes(x = id, y = Abundance, fill = Family)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Family_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the microeukaryotic Family (top12) in April", 
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
print(relative_abundance_Family_top12_april)
ggsave("relative_abundance_Family_top12_april_275_v132.jpeg", plot = relative_abundance_Family_top12_april, width = 10, height = 6, dpi = 300)

relative_abundance_Family_top12_july <- ggplot(df_phyla_july, aes(x = id, y = Abundance, fill = Family)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Family_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the microeukaryotic Family (top12) in July", 
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
print(relative_abundance_Family_top12_july)
ggsave("relative_abundance_Family_top12_july_275_v132.jpeg", plot = relative_abundance_Family_top12_july, width = 10, height = 6, dpi = 300)
