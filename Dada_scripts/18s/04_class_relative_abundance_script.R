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

ps_na_Class <- ps_na

# Get the taxonomic information
tax_info <- tax_table(ps_na_Class)

# Get the Class column
Class_info <- tax_info[,"Class"]

ps_na_Class <- transform_sample_counts(ps_na_Class, function(x) x / sum(x))

# Sum the counts for each Class
Class_counts <- tapply(taxa_sums(ps_na_Class), Class_info, sum)

top12_Class <- names(sort(Class_counts, decreasing=TRUE))[1:12]

# Get the ASVs that belong to the top 12 Class
top12_ASVs <- rownames(tax_info)[tax_info[,"Class"] %in% top12_Class]

# Prune the taxa based on these ASVs
ps_na_Class.top12_Class <- prune_taxa(top12_ASVs, ps_na_Class)

ps_na_Class.top12_Class_arpil <- subset_samples(ps_na_Class.top12_Class, Month == "April")
ps_na_Class.top12_Class_july <- subset_samples(ps_na_Class.top12_Class, Month == "July")

df_Class_april <- psmelt(ps_na_Class.top12_Class_arpil)
df_Class_july <- psmelt(ps_na_Class.top12_Class_july)

df_Class_april$id <- factor(df_Class_april$id, levels = desired_order_april)
df_Class_july$id <- factor(df_Class_july$id, levels = desired_order_july)

# Задаем палитру
Сlass_colors <- c(
  "Cercomonadidae" = "#2217be",
  "Chlorophyceae" = "#9467bd",
  "Chrysophyceae" = "#ff7f0e",
  "Cryptomonadales_cl" = "#e1e323",
  "Diatomea" = "#2ca02c",
  "Dinophyceae" = "#d62728", 
  "Eustigmatophyceae" = "#f3a400",
  "Incertae_Sedis_cl" = "#17be22",
  "Intramacronucleata" = "#1f77b4", 
  "Thecofilosea" = "#8c564b",
  "Trebouxiophyceae" = "#e377c2", 
  "Ulvophyceae" = "#7f7f7f")


# Построение графика Class
relative_abundance_Class_top12_april <- ggplot(df_Class_april, aes(x = id, y = Abundance, fill = Class)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Сlass_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the microeukaryotic Class (top12) in April", 
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
ggsave("relative_abundance_Class_top12_april_275_v132.jpeg", plot = relative_abundance_Class_top12_april, width = 10, height = 12, dpi = 300)

relative_abundance_Class_top12_july <- ggplot(df_Class_july, aes(x = id, y = Abundance, fill = Class)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = Сlass_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the microeukaryotic Class (top12) in July", 
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
print(relative_abundance_Class_top12_july)
ggsave("relative_abundance_Class_top12_july_275_v132.jpeg", plot = relative_abundance_Class_top12_july, width = 10, height = 12, dpi = 300)

