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

ps_na_phylum <- ps_na

# Get the taxonomic information
tax_info <- tax_table(ps_na_phylum)

# Get the Phylum column
phylum_info <- tax_info[,"Phylum"]

# Sum the counts for each Phylum
phylum_counts <- tapply(taxa_sums(ps_na_phylum), phylum_info, sum)

top12_phyla <- names(sort(phylum_counts, decreasing=TRUE))[1:12]

# Get the ASVs that belong to the top 12 phyla
top12_ASVs <- rownames(tax_info)[tax_info[,"Phylum"] %in% top12_phyla]

# Prune the taxa based on these ASVs
ps_na_phylum.top12_phyla <- prune_taxa(top12_ASVs, ps_na_phylum)

ps_na_phylum.top12_phyla_arpil <- subset_samples(ps_na_phylum.top12_phyla, Month == "April")
ps_na_phylum.top12_phyla_july <- subset_samples(ps_na_phylum.top12_phyla, Month == "July")

df_phyla_april <- psmelt(ps_na_phylum.top12_phyla_arpil)
df_phyla_july <- psmelt(ps_na_phylum.top12_phyla_july)

df_phyla_april$id <- factor(df_phyla_april$id, levels = desired_order_april)
df_phyla_july$id <- factor(df_phyla_july$id, levels = desired_order_july)

# Create color set
phylum_colors <- c(
  "Ochrophyta" = "#1f77b4", 
  "Ciliophora" = "#ff7f0e", 
  "Dinoflagellata" = "#2ca02c", 
  "Cercozoa" = "#d62728", 
  "Cryptomonadales" = "#9467bd", 
  "Peronosporomycetes" = "#8c564b", 
  "Chytridiomycota" = "#e377c2", 
  "Cryptomycota" = "#7f7f7f", 
  "Protalveolata" = "#bcbd22", 
  "Prymnesiophyceae" = "#17becf",
  "Bicosoecida" = "#1a55FF",
  "Ichthyosporea" = "#8B572A",
  "Rotifera" = "#6baed6",
  "Chlorophyta_ph" = "#fd8d3c",
  "Opisthokonta" = "#74c476",
  "Cryptophyceae" = "#9e9ac8",
  "Haptophyta" = "#e6550d",
  "Phragmoplastophyta" = "#6a51a3",
  "Bacteroidetes" = "#dadaeb"
)

# phylum barplots
relative_abundance_phylum_top12_april <- ggplot(df_phyla_april, aes(x = id, y = Abundance, fill = Phylum)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = phylum_colors) + 
  labs(title = "Relative abundances of the microeukaryotic phylum (top12) in April", 
       x = "samples", 
       y = "abundance") +
  theme(
    plot.title = element_text(hjust = 0.5, size = 15), 
    axis.title.x = element_text(size = 15), 
    axis.title.y = element_text(size = 15), 
    axis.text.x = element_text(angle = 45, hjust = 1, size = 15), 
    legend.text = element_text(size = 10),
    theme_minimal() 
  )
print(relative_abundance_phylum_top12_april)
ggsave("relative_abundance_phylum_top12_april_275_v132.jpeg", plot = relative_abundance_phylum_top12_april, width = 10, height = 6, dpi = 300)

relative_abundance_phylum_top12_july <- ggplot(df_phyla_july, aes(x = id, y = Abundance, fill = Phylum)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = phylum_colors) + 
  labs(title = "Relative abundances of the microeukaryotic phylum (top12) in July", 
       x = "samples", 
       y = "abundance") +
  theme(
    plot.title = element_text(hjust = 0.5, size = 15), 
    axis.title.x = element_text(size = 15), 
    axis.title.y = element_text(size = 15), 
    axis.text.x = element_text(angle = 45, hjust = 1, size = 15), 
    legend.text = element_text(size = 10),
    theme_minimal() 
  )
print(relative_abundance_phylum_top12_july)
ggsave("relative_abundance_phylum_top12_july_275_v132.jpeg", plot = relative_abundance_phylum_top12_july, width = 10, height = 6, dpi = 300)
