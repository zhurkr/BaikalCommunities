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
# Get current tax table
taxa <- tax_table(ps_nc)

# Get Phylum info
phylum_info <- taxa[,"Phylum"]

# Count each phylum
phylum_counts <- table(phylum_info)

# Sort phylum based on counts in decreasing order
phylum_counts <- sort(phylum_counts, decreasing = TRUE)

# Get top 12 phylum
top12_phyla <- names(phylum_counts)[1:12]

# Print top 12 phylum and phylum counts
print(top12_phyla)
print(phylum_counts[top12_phyla])

ps_nc_phylum <- ps_nc

# Get the taxonomic information
tax_info <- tax_table(ps_nc_phylum)

# Get the Phylum column
phylum_info <- tax_info[,"Phylum"]

# Sum the counts for each Phylum
phylum_counts <- tapply(taxa_sums(ps_nc_phylum), phylum_info, sum)

top12_phyla <- names(sort(phylum_counts, decreasing=TRUE))[1:12]

# Get the ASVs that belong to the top 12 phyla
top12_ASVs <- rownames(tax_info)[tax_info[,"Phylum"] %in% top12_phyla]

# Prune the taxa based on these ASVs
ps_nc_phylum.top12_phyla <- prune_taxa(top12_ASVs, ps_nc_phylum)

ps_nc_phylum.top12_phyla_arpil <- subset_samples(ps_nc_phylum.top12_phyla, Month == "April")
ps_nc_phylum.top12_phyla_july <- subset_samples(ps_nc_phylum.top12_phyla, Month == "July")

df_phyla_april <- psmelt(ps_nc_phylum.top12_phyla_arpil)
df_phyla_july <- psmelt(ps_nc_phylum.top12_phyla_july)

df_phyla_april$ID <- factor(df_phyla_april$ID, levels = desired_order_april)
df_phyla_july$ID <- factor(df_phyla_july$ID, levels = desired_order_july)

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
relative_abundance_phylum_top12_april <- ggplot(df_phyla_april, aes(x = ID, y = Abundance, fill = Phylum)) +
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

print(relative_abundance_phylum_top12_april)
ggsave("relative_abundance_phylum_top12_april_275.jpeg", plot = relative_abundance_phylum_top12_april, width = 10, height = 6, dpi = 300)

relative_abundance_phylum_top12_july <- ggplot(df_phyla_july, aes(x = ID, y = Abundance, fill = Phylum)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = phylum_colors) + # Используем заданную палитру
  labs(title = "Relative abundances of the PA bacterial phylum (top12) in July", 
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
print(relative_abundance_phylum_top12_july)
ggsave("relative_abundance_phylum_top12_july_275.jpeg", plot = relative_abundance_phylum_top12_july, width = 10, height = 6, dpi = 300)
