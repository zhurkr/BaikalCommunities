library(phyloseq)
library(ggplot2)

desired_order_april <- c("UW1/0_5",
                         "UW1/5_5",
                         "UW2/0_5",
                         "UW2/5_5",
                         "UW2/10_5",
                         "UW2/30_5",
                         "UW3/0_5",
                         "UW3/5_5",
                         "UW3/10_5",
                         "UW3/30_5"
)

desired_order_july <- c("PL1/0_5",
                        "PL1/3_5",
                        "PL1/7_5",
                        "PL2/0_5",
                        "PL2/5_5",
                        "PL2/10_5",
                        "PL2/30_5",
                        "PL3/0_5",
                        "PL3/5_5",
                        "PL3/10_5",
                        "PL3/30_5")

ps_na_Family <- ps_na

# Get the taxonomic information
tax_info <- tax_table(ps_na_Family)

# Get the Family column
Family_info <- tax_info[,"Family"]

ps_na_Family <- transform_sample_counts(ps_na_Family, function(x) x / sum(x))

# Sum the counts for each Family
Family_counts <- tapply(taxa_sums(ps_na_Family), Family_info, sum)

top12_Family <- names(sort(Family_counts, decreasing=TRUE))[1:12]

# Get the ASVs that belong to the top 12 Family
top12_ASVs <- rownames(tax_info)[tax_info[,"Family"] %in% top12_Family]

# Prune the taxa based on these ASVs
ps_na_Family.top12_Family <- prune_taxa(top12_ASVs, ps_na_Family)

ps_na_Family.top12_Family_arpil <- subset_samples(ps_na_Family.top12_Family, Month == "April")
ps_na_Family.top12_Family_july <- subset_samples(ps_na_Family.top12_Family, Month == "July")

df_Family_april <- psmelt(ps_na_Family.top12_Family_arpil)
df_Family_july <- psmelt(ps_na_Family.top12_Family_july)

df_Family_april$id <- factor(df_Family_april$id, levels = desired_order_april)
df_Family_july$id <- factor(df_Family_july$id, levels = desired_order_july)

# Задаем палитру
Family_colors <- c(
  "Fragilariales" = "#2ca02c",
  "Thoracosphaeraceae" = "#8c564b",
  "Gymnodinium_clade" = "#ee1eee",
  "Oligotrichia" = "#ff7f0e",
  "Chromulinales_fa" = "#11a1ff",
  "Mediophyceae" = "#e377c2",
  "Chlamydomonadales_fa" = "#91f2a4",
  "Gymnodiniphycidae_fa" = "#d6226d",
  "Choreotrichia" = "#1f77b4",
  "Ochromonadales_fa"  = "#7f7f7f",
  "Hypotrichia" = "#1a55FF",
  "Ulotrichales_fa" = "#FF1a55")


# Построение графика Family
relative_abundance_Family_top12_april <- ggplot(df_Family_april, aes(x = id, y = Abundance, fill = Family)) +
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
ggsave("relative_abundance_Family_top12_april_275_v132.jpeg", plot = relative_abundance_Family_top12_april, width = 10, height = 12, dpi = 300)

relative_abundance_Family_top12_july <- ggplot(df_Family_july, aes(x = id, y = Abundance, fill = Family)) +
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
ggsave("relative_abundance_Family_top12_july_275_v132.jpeg", plot = relative_abundance_Family_top12_july, width = 10, height = 12, dpi = 300)
