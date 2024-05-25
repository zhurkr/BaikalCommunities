# Load necessary libraries
library(tidyr)
library(ggplot2)
if (!require(cowplot)) install.packages("cowplot")
library(cowplot)

# Set the working directory
setwd("D:/Baikal_v3/16S_275")


# Read phylum data from a file
data_phylum<-read.csv("BD.z_phylum_summary.txt", header=TRUE, sep="\t", check.names = FALSE)

# Remove the last column ("all")
data_phylum <- data_phylum[,-ncol(data_phylum)] #remove column "all"

# Rearrange columns
data_phylum <- data_phylum[c(1, 10, 20, 31, 35:38, 2:9, 11:19, 21:30, 32:34)]

# Rename columns
colnames(data_phylum)[2:38] <- c('V1UI-0-FL', 'V1UI-0-PA', 'V1UI-5-FL', 'V1UI-5-PA', 'V2UI-0-FL', 'V2UI-0-PA', 'V2UI-5-FL', 'V2UI-30-FL', 'V2UI-30-PA', 'V3UI-0-FL', 'V3UI-0-PA', 'V3UI-5-FL', 'V3UI-10-FL', 'V3UI-10-PA', 'V3UI-30-FL', 'V3UI-30-PA', 'V1PL-0-FL', 'V1PL-0-PA', 'V1PL-3-FL', 'V1PL-3-PA', 'V1PL-7-FL', 'V2PL-0-FL', 'V2PL-0-PA', 'V2PL-5-FL', 'V2PL-5-PA', 'V2PL-10-FL', 'V2PL-10-PA', 'V2PL-30-FL', 'V2PL-30-PA', 'V3PL-0-FL', 'V3PL-0-PA', 'V3PL-5-FL', 'V3PL-5-PA', 'V3PL-10-FL', 'V3PL-10-PA', 'V3PL-30-FL', 'V3PL-30-PA')

# Remove the row for "Unassigned"
data_phylum <- data_phylum[-4, ]  #deleted Unassigned

# Keep only the top 12 rows (top 12 phyla)
data_phylum_top12 <- data_phylum[c(1:12), ] #leave top12

# Replace "Cyanobacteria/Chloroplast" with "Cyanobacteria"
data_phylum_top12[5, 1] <- "Cyanobacteria"

# Get column indices for columns containing "FL" and "PA" in their names
fl_columns <- grep("FL", names(data_phylum_top12))
pa_columns <- grep("PA", names(data_phylum_top12))

# Get indices of other columns
other_columns <- setdiff(seq_along(data_phylum_top12), c(fl_columns, pa_columns))

# Split the data by lifestyle into FL and PA
data_phylum_top12_FL <- data_phylum_top12[,c(other_columns, fl_columns)]
data_phylum_top12_PA <- data_phylum_top12[,c(other_columns, pa_columns)]

# Create four data frames for different time points and lifestyles
data_phylum_top12_FL04 <- data_phylum_top12_FL[c(1:10)]
data_phylum_top12_FL07 <- data_phylum_top12_FL[c(1, 11:21)]
data_phylum_top12_PA04 <- data_phylum_top12_PA[c(1:8)]
data_phylum_top12_PA07 <- data_phylum_top12_PA[c(1, 9:18)]

# Define custom colors for phyla
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
  "Candidatus_Saccharibacteria"  = "#ff1493"
)


#change format from wide to long
data_phylum_top12_FL04_long <- pivot_longer(
  data_phylum_top12_FL04, 
  cols = -Phylum)

data_phylum_top12_PA04_long <- pivot_longer(
  data_phylum_top12_PA04, 
  cols = -Phylum)

data_phylum_top12_FL07_long <- pivot_longer(
  data_phylum_top12_FL07, 
  cols = -Phylum)

data_phylum_top12_PA07_long <- pivot_longer(
  data_phylum_top12_PA07, 
  cols = -Phylum)

# Define sample orders for plotting
sample_order_FL <- c(
"V1UI-0-FL",
"V1UI-5-FL",
"V2UI-0-FL",
"V2UI-5-FL",
"V2UI-10-FL",
"V2UI-30-FL",
"V3UI-0-FL",
"V3UI-5-FL",
"V3UI-10-FL",
"V3UI-30-FL")

# Set factor levels for sample names to ensure correct order in plots
data_phylum_top12_FL04_long$name <- factor(data_phylum_top12_FL04_long$name, levels = sample_order_FL)

# Create bar plot
FL04 <- ggplot(data_phylum_top12_FL04_long, aes(x = name, y = value, fill = Phylum)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = phylum_colors) + 
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


print(FL04)

# Define sample orders for plotting
sample_order_PA <- c("V1UI-0-PA",
                                "V1UI-5-PA",
                                "V2UI-0-PA",
                                "V2UI-5-PA",
                                "V2UI-30-PA",
                                "V3UI-0-PA",
                                "V3UI-10-PA")

# Set factor levels for sample names to ensure correct order in plots
data_phylum_top12_PA04_long$name <- factor(data_phylum_top12_PA04_long$name, levels = sample_order_PA)

# Create bar plot
PA04 <- ggplot(data_phylum_top12_PA04_long, aes(x = name, y = value, fill = Phylum)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = phylum_colors) + 
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
print (PA04)

# Define sample orders for plotting
sample_order_FL07 <- c("V1PL-0-FL",
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

# Set factor levels for sample names to ensure correct order in plots
data_phylum_top12_FL07_long$name <- factor(data_phylum_top12_FL07_long$name, levels = sample_order_FL07)

# Create bar plot
FL07 <- ggplot(data_phylum_top12_FL07_long, aes(x = name, y = value, fill = Phylum)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = phylum_colors) + 
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

print(FL07)

# Define sample orders for plotting
sample_order_PA07 <- c("V1PL-0-PA",
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

# Set factor levels for sample names to ensure correct order in plots
data_phylum_top12_PA07_long$name <- factor(data_phylum_top12_PA07_long$name, levels = sample_order_PA07)

# Create bar plot
PA07<- ggplot(data_phylum_top12_PA07_long, aes(x = name, y = value, fill = Phylum)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = phylum_colors) + 
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
print (PA07)

# Create a version of the PA07 plot with legend for extracting legend
PA07legenda <- ggplot(data_phylum_top12_PA07_long, aes(x = name, y = value, fill = Phylum)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = phylum_colors) + 
  labs(title = "PA bacterial phylum in July",
       x = "Samples",
       y = "Abundance") +
  theme_minimal() + 
  theme(plot.title = element_text(hjust = 0.5, size = 15), 
        axis.title.x = element_text( size = 10), 
        axis.title.y = element_text(size = 10), 
        axis.text.x = element_text(angle = 45, hjust = 1, size = 11), 
        legend.text = element_text(size = 15)) 

# Extract the legend from the PA07legenda plot
legend <- get_legend(PA07legenda)

# Combine the plots without legend and add the extracted legend
combined_plot <- plot_grid(
  plot_grid(FL04, FL07, PA04, PA07, ncol = 2, align = 'v'),
  legend,
  ncol = 2,
  rel_widths = c(1, 0.6))

# Save the combined plot
ggsave("phylum_abundance_combined_plot.jpeg", combined_plot, width = 10, height = 15, dpi = 300)


