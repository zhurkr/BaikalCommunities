
# Load necessary libraries
library(ggplot2)
library(cowplot)
library(readxl)
library(dplyr)

# Set the working directory
setwd("D:/Baikal_v3/18S_275")

# Read the data from a CSV file
data_count<-read.csv("BD.zotutab_filtr.txt", header=TRUE, sep="\t", check.names = FALSE)

# Rearrange the columns in a specified order
data_count <- data_count[c(1, 10, 18:21, 2:9, 11:17)]

# Rename columns
colnames(data_count)[2:21] <- c("UW1/0_5", "UW1/5_5", "UW2/0_5", "UW2/5_5", "UW2/10_5", "UW3/0_5", "UW3/5_5", "UW3/10_5", "UW3/30_5", "PL1/0_5", "PL1/3_5", "PL1/7_5", "PL2/0_5", "PL2/5_5", "PL2/10_5", "PL2/30_5", "PL3/0_5", "PL3/5_5", "PL3/10_5", "PL3/30_5")

# Set row names and remove the first column
rownames(data_count)<-data_count[,1]
data_count<-data_count[,-1]

# Read alpha diversity data
data_alpha <-read.csv("bac_z_diversity.txt", header=TRUE, sep="\t", check.names = FALSE)

# Rename columns
data_alpha[9,1] <- "X02"
data_alpha[17,1] <- "X04"
data_alpha[18,1] <- "X06"
data_alpha[19,1] <- "X08"
data_alpha[20,1] <- "X09"

# Rearrange the rowss in a specified order
data_alpha <- data_alpha %>% 
  arrange(sample_id)

# Rename columns
data_alpha$sample_id <- c("UW1/0_5", "UW1/5_5", "UW2/0_5", "UW2/5_5", "UW2/10_5", "UW3/0_5", "UW3/5_5", "UW3/10_5", "UW3/30_5", "PL1/0_5", "PL1/3_5", "PL1/7_5", "PL2/0_5", "PL2/5_5", "PL2/10_5", "PL2/30_5", "PL3/0_5", "PL3/5_5", "PL3/10_5", "PL3/30_5")

# Read metadata
metadata <- read_excel("Metadata_Varnachka_new_modified_filtred.xlsx", sheet = 2, col_names = TRUE)
data_merged <- merge(data_alpha, metadata, by = "sample_id")

# Convert Month column to factor
data_merged$Month <- as.factor(data_merged$Month)

#Split data into two groups(April and July) for simpson index
group_A_S <- filter(data_merged, Month == "April")$simpson
group_J_S <-  filter(data_merged, Month == "July")$simpson

# Perform Wilcoxon test for Simpson index 
wilcox_test_s <- wilcox.test(group_A_S, group_J_S)
print(wilcox_test_s)
p_value_s <- round(wilcox_test_s$p.value, 3)

# Create boxplot for Simpson index
simpson <- ggplot(data_merged, aes(x = Month, y = simpson)) + 
  geom_boxplot(aes(fill = Month), colour = "black") + 
  labs(title = "Simpson", x = "", y = "") + 
  theme_minimal() +
  geom_point(position = position_jitter(width = 0.2), size = 1.5, alpha = 0.5) +
  theme(plot.title = element_text(hjust = 0.5, size = 22), axis.title.x = element_text(size = 18), axis.title.y = element_text(size = 16),  axis.text.x = element_text(size = 18),  axis.text.y = element_text(size = 16),
        legend.position = "none") +
  annotate("text", x = 1, y = max(data_merged$simpson), label = sprintf("p-value = %.4f", p_value_s), hjust =-0.5, vjust = -0.5)

ggsave("simpson.jpeg", plot = simpson, width = 10, height = 6, dpi = 300)


#Split data into two groups (April and July) for ACE index
group_A_ACE <- filter(data_merged, Month == "April")$S.ACE
group_J_ACE <-  filter(data_merged, Month == "July")$S.ACE

# Perform Wilcoxon test for ACE index 
wilcox_test_ace <- wilcox.test(group_A_ACE, group_J_ACE)
print(wilcox_test_ace)
p_value_ace <- round(wilcox_test_ace$p.value, 3)

# Create boxplot for ACE index 
ace <- ggplot(data_merged, aes(x = Month, y = S.ACE)) + 
  geom_boxplot(aes(fill = Month), colour = "black") +
  labs(title = "ACE", x = "", y = "Alpha diversity measure") + 
  theme_minimal() +
  geom_point(position = position_jitter(width = 0.2), size = 1.5, alpha = 0.5) +
  theme(plot.title = element_text(hjust = 0.5, size = 22), axis.title.x = element_text(size = 18), axis.title.y = element_text(size = 16),  axis.text.x = element_text(size = 18), axis.text.y = element_text(size = 16),
        legend.position = "none") +
  annotate("text", x = 1, y = max(data_merged$S.ACE), label = sprintf("p-value = %.4f", p_value_ace), hjust = -0.5, vjust = -0.5)
ggsave("ACE.jpeg", plot = ace, width = 10, height = 6, dpi = 300)



#Split data into two groups (April and July) for shannon index
group_A_SN <- filter(data_merged, Month == "April")$shannon
group_J_SN <-  filter(data_merged, Month == "July")$shannon

# Perform Wilcoxon test for Shannon index
wilcox_test_sn <- wilcox.test(group_A_SN, group_J_SN)
print(wilcox_test_sn)
p_value_sn <- round(wilcox_test_sn$p.value, 4)

# Create boxplot for Shannon index 
shannon <- ggplot(data_merged, aes(x = Month, y = shannon)) + 
  geom_boxplot(aes(fill = Month), colour = "black") +
  labs(title = "Shannon", x = "", y = "") + 
  theme_minimal() +
  geom_point(position = position_jitter(width = 0.2), size = 1.5, alpha = 0.5) +
  theme(plot.title = element_text(hjust = 0.5, size = 22), axis.title.x = element_text(size = 18), axis.title.y = element_text(size = 16),  axis.text.x = element_text(size = 18),  axis.text.y = element_text(size = 16),
        legend.position = "none") +
  annotate("text", x = 1, y = max(data_merged$shannon), label = sprintf("p-value = %.4f", p_value_sn), hjust = -0.5, vjust = -0.5)
ggsave("shannon.jpeg", plot = shannon, width = 10, height = 6, dpi = 300)


# Save combined plot
ggsave("combined_plot.jpeg", plot_grid(ace, shannon, simpson, ncol = 3, align = 'none'), width = 10, height = 7, dpi = 300)



