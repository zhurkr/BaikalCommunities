# Load necessary libraries

library(tidyr)
library(ggplot2)
if (!require(cowplot)) install.packages("cowplot")
library(cowplot)

# Set the working directory
setwd("D:/Baikal_v3/18S_275")

# Read data from a file
data_family<-read.csv("BD.z_family_summary.txt", header=TRUE, sep="\t", check.names = FALSE)

# Remove the last column ("all")
data_family <- data_family[,-ncol(data_family)]

# Rearrange columns
data_family <- data_family[c(1, 10, 18:21, 2:9, 11:17)]

# Rename columns
colnames(data_family)[2:21] <- c("UW1/0_5", "UW1/5_5", "UW2/0_5", "UW2/5_5", "UW2/10_5", "UW3/0_5", "UW3/5_5", "UW3/10_5", "UW3/30_5", "PL1/0_5", "PL1/3_5", "PL1/7_5", "PL2/0_5", "PL2/5_5", "PL2/10_5", "PL2/30_5", "PL3/0_5", "PL3/5_5", "PL3/10_5", "PL3/30_5")

# Remove the row for "Unassigned"
data_family <- data_family[-1, ]  #deleted Unassigned

#leave top12
data_family_top12 <- data_family[c(1:12), ]

# Get column indices for columns containing "UW" and "PL" in their names
UW_columns <- grep("UW", names(data_family_top12))
PL_columns <- grep("PL", names(data_family_top12))

# Get indices of other columns
other_columns <- setdiff(seq_along(data_family_top12), c(UW_columns, PL_columns))

# Split the data by lifestyle into UW and PL
data_family_top12_04 <- data_family_top12[,c(other_columns, UW_columns)]
data_family_top12_07 <- data_family_top12[,c(other_columns, PL_columns)]


# Define custom colors
family_colors <- c(
  "Choreotrichia" = "#1f77b4",
  "Fragilariales" = "#2ca02c",
  "Oligotrichia" = "#ff7f0e", 
  "Bacillariophyceae" = "#9467bd",
  "Thoracosphaeraceae" = "#8c564b",
  "Mediophyceae" = "#e377c2",
  "Oligohymenophorea" = "#d62728", 
  "Ochromonadales_fa"  = "#7f7f7f",
  "Hypotrichia" = "#1a55FF",
  "Haptoria" = "#bcbd22",
  "Suessiaceae" = "#17becf",
  "Cryptomonadales_fa" = "#8B572A"
)

#change format from wide to long
data_family_top12_04_long <- pivot_longer(
  data_family_top12_04, 
  cols = -Family)

data_family_top12_07_long <- pivot_longer(
  data_family_top12_07, 
  cols = -Family)

# Define sample orders for plotting
sample_order_04 <- c("UW1/0_5",
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

# Set factor levels for sample names to ensure correct order in plots
data_family_top12_04_long$name <- factor(data_family_top12_FL04_long$name, levels = sample_order_04)

# Create bar plot
UW04 <- ggplot(data_family_top12_04_long, aes(x = name, y = value, fill = Family)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = family_colors) + 
  labs(title = "April",
       x = "Samples",
       y = "Abundance") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 30), 
        axis.title.x = element_text( size = 10), 
        axis.title.y = element_text(size = 10), 
        axis.text.x = element_text(angle = 45, hjust = 1, size = 10), 
        legend.text = element_text(size = 15),
        legend.position = "none")


print(UW04)

# Define sample orders for plotting
sample_order_07 <- c("PL1/0_5",
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

# Set factor levels for sample names to ensure correct order in plots
data_family_top12_07_long$name <- factor(data_family_top12_07_long$name, levels = sample_order_07)

# Create bar plot
PL07 <- ggplot(data_family_top12_07_long, aes(x = name, y = value, fill = Family)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = family_colors) + 
  labs(title = "July",
       x = "Samples",
       y = "Abundance") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 30), 
        axis.title.x = element_text( size = 10), 
        axis.title.y = element_text(size = 10), 
        axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
        legend.text = element_text(size = 15),
        legend.position = "none")

print(PL07)

# Create EU07 plot with legend for extracting legend
EU07legenda <- ggplot(data_family_top12_07_long, aes(x = name, y = value, fill = Family)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = family_colors) + 
  labs(title = "Microeukaryotic family in July",
       x = "Samples",
       y = "Abundance") +
  theme_minimal() + 
  theme(plot.title = element_text(hjust = 0.5, size = 15), 
        axis.title.x = element_text( size = 10), 
        axis.title.y = element_text(size = 10), 
        axis.text.x = element_text(angle = 45, hjust = 1, size = 10), 
        legend.text = element_text(size = 15))


# Extract the legend from the EU07legenda plot
legend <- get_legend(EU07legenda)

# Combine the plots without legend and add the extracted legend 
combined_plot <- plot_grid(
  plot_grid(UW04, PL07, ncol = 2, align = 'v'),
  legend,
  ncol = 2,
  rel_widths = c(1, 0.6) 
)

# Save the combined plot
ggsave("family_abundance_combined_plot.jpeg", combined_plot, width = 10, height = 12, dpi = 300)


