library(tidyverse)
library(phyloseq); packageVersion("phyloseq")
library(ggplot2); packageVersion("ggplot2")

ps_nc_Family <- ps_nc

# Get the taxonomic information
tax_info <- tax_table(ps_nc_Family)

# Get the Family column
Family_info <- tax_info[,"Family"]

# Sum the counts for each Family
Family_counts <- tapply(taxa_sums(ps_nc_Family), Family_info, sum)

top12_Family <- names(sort(Family_counts, decreasing=TRUE))[1:12]

# Get the ASVs that belong to the top 12 Family
top12_ASVs <- rownames(tax_info)[tax_info[,"Family"] %in% top12_Family]

# Prune the taxa based on these ASVs
ps_nc_Family.top12_Family <- prune_taxa(top12_ASVs, ps_nc_Family)

ps_nc_Family.top12_Family_arpil <- subset_samples(ps_nc_Family.top12_Family, Month == "April")
ps_nc_Family.top12_Family_july <- subset_samples(ps_nc_Family.top12_Family, Month == "July")

df_Family_april <- psmelt(ps_nc_Family.top12_Family_arpil)
df_Family_july <- psmelt(ps_nc_Family.top12_Family_july)

df_Family_april$ID <- factor(df_Family_april$ID, levels = desired_order_april)
df_Family_july$ID <- factor(df_Family_july$ID, levels = desired_order_july)

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
relative_abundance_Family_top12_april <- ggplot(df_Family_april, aes(x = ID, y = Abundance, fill = Family)) +
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

print(relative_abundance_Family_top12_april)
ggsave("relative_abundance_Family_top12_april_275.jpeg", plot = relative_abundance_Family_top12_april, width = 10, height = 6, dpi = 300)

relative_abundance_Family_top12_july <- ggplot(df_Family_july, aes(x = ID, y = Abundance, fill = Family)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Family_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the PA bacterial Family (top12) in July", 
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
print(relative_abundance_Family_top12_july)
ggsave("relative_abundance_Family_top12_july_275.jpeg", plot = relative_abundance_Family_top12_july, width = 10, height = 6, dpi = 300)
