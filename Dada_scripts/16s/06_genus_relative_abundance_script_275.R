library(tidyverse)
library(phyloseq); packageVersion("phyloseq")
library(ggplot2); packageVersion("ggplot2")

ps_nc_Genus <- ps_nc

# Get the taxonomic information
tax_info <- tax_table(ps_nc_Genus)

# Get the Genus column
Genus_info <- tax_info[,"Genus"]

# Sum the counts for each Genus
Genus_counts <- tapply(taxa_sums(ps_nc_Genus), Genus_info, sum)

top12_Genus <- names(sort(Genus_counts, decreasing=TRUE))[1:12]

# Get the ASVs that belong to the top 12 Genus
top12_ASVs <- rownames(tax_info)[tax_info[,"Genus"] %in% top12_Genus]

# Prune the taxa based on these ASVs
ps_nc_Genus.top12_Genus <- prune_taxa(top12_ASVs, ps_nc_Genus)

ps_nc_Genus.top12_Genus_arpil <- subset_samples(ps_nc_Genus.top12_Genus, Month == "April")
ps_nc_Genus.top12_Genus_july <- subset_samples(ps_nc_Genus.top12_Genus, Month == "July")

df_Genus_april <- psmelt(ps_nc_Genus.top12_Genus_arpil)
df_Genus_july <- psmelt(ps_nc_Genus.top12_Genus_july)

df_Genus_april$ID <- factor(df_Genus_april$ID, levels = desired_order_april)
df_Genus_july$ID <- factor(df_Genus_july$ID, levels = desired_order_july)

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
  "Polynucleobacter" = "#17becf",
  "Pseudomonas" = "#1a55FF",
  "Desertimonas" = "#aa7f0e",
  "Ilumatobacter" = "#2ca099",
  "Lishizhenia" = "#060028",
  "Limnohabitans" = "#e300c2",
  "Rhodoferax" = "#9400bd",
  "Armatimonas/Armatimonadetes_gp1" = "#8c004b",
  "Sediminibacterium" = "#7fd07f",
  "Gimesia" = "#1713cf",
  "Arcicella" = "#af1f00"
)
# Genus barplot
relative_abundance_Genus_top12_april <- ggplot(df_Genus_april, aes(x = ID, y = Abundance, fill = Genus)) +
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

print(relative_abundance_Genus_top12_april)
ggsave("relative_abundance_Genus_top12_april_275.jpeg", plot = relative_abundance_Genus_top12_april, width = 10, height = 6, dpi = 300)

relative_abundance_Genus_top12_july <- ggplot(df_Genus_july, aes(x = ID, y = Abundance, fill = Genus)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Genus_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the PA bacterial Genus (top12) in July", 
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
print(relative_abundance_Genus_top12_july)
ggsave("relative_abundance_Genus_top12_july_275.jpeg", plot = relative_abundance_Genus_top12_july, width = 10, height = 6, dpi = 300)
