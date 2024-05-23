# Load necessary libraries
library(ggplot2)
library(cowplot)
library(readxl)
library(dplyr)

# Set the working directory
setwd("D:/Baikal_v3/16S_275")

# Read the data from a CSV file
data_count<-read.csv("updated_BD.zotutab_filtr.txt", header=TRUE, sep="\t", check.names = FALSE)

# Rearrange the columns in a specified order
data_count <- data_count[c(1, 10, 20, 31, 35:38, 2:9, 11:19, 21:30, 32:34)]

# Rename columns
colnames(data_count)[c( 2, 3, 4, 5, 6, 7, 8)] <- c("X01", "X02", "X03", "X04", "X05", "X06", "X07")
colnames(data_count)[2:38] <- c('V1UI-0-FL', 'V1UI-0-PA', 'V1UI-5-FL', 'V1UI-5-PA', 'V2UI-0-FL', 'V2UI-0-PA', 'V2UI-5-FL', 'V2UI-30-FL', 'V2UI-30-PA', 'V3UI-0-FL', 'V3UI-0-PA', 'V3UI-5-FL', 'V3UI-10-FL', 'V3UI-10-PA', 'V3UI-30-FL', 'V3UI-30-PA', 'V1PL-0-FL', 'V1PL-0-PA', 'V1PL-3-FL', 'V1PL-3-PA', 'V1PL-7-FL', 'V2PL-0-FL', 'V2PL-0-PA', 'V2PL-5-FL', 'V2PL-5-PA', 'V2PL-10-FL', 'V2PL-10-PA', 'V2PL-30-FL', 'V2PL-30-PA', 'V3PL-0-FL', 'V3PL-0-PA', 'V3PL-5-FL', 'V3PL-5-PA', 'V3PL-10-FL', 'V3PL-10-PA', 'V3PL-30-FL', 'V3PL-30-PA')

# Set row names and remove the first column
rownames(data_count)<-data_count[,1]
data_count<-data_count[,-1]

# Read alpha diversity data
data_alpha <-read.csv("bac_z_diversity.txt", header=TRUE, sep="\t", check.names = FALSE)

# Read metadata
metadata <- read_excel("Metadata_Varnachka_new_modified_filtred.xlsx", col_names = TRUE)

# Merge alpha diversity data with metadata
data_merged <- merge(data_alpha, metadata, by = "sample_id")

# Convert Month and Lifestyle columns to factors
data_merged$Month <- as.factor(data_merged$Month)
data_merged$Lifestyle <- as.factor(data_merged$Lifestyle)

# Sort merged data by Lifestyle
data_merged_sorted_lifestyle <- data_merged %>% 
  arrange(Lifestyle)

#Split data into two groups: FL and PA
data_merged_FL <- data_merged_sorted_lifestyle[1:20, ]
data_merged_PA <- data_merged_sorted_lifestyle[21:37, ]


# Perform Wilcoxon test for Simpson index for FL group
group_FL_A_S <- filter(data_merged_FL, Month == "April")$simpson
group_FL_J_S <-  filter(data_merged_FL, Month == "July")$simpson
wilcox_test_fls <- wilcox.test(group_FL_A_S, group_FL_J_S)
print(wilcox_test_fls)
p_value_fls <- round(wilcox_test_fls$p.value, 3)

# Create boxplot for Simpson index for FL group
simpson_FL <- ggplot(data_merged_FL, aes(x = Month, y = simpson)) + 
  geom_boxplot(aes(fill = Month), colour = "black") + 
  labs(title = "Simpson_FL", x = "", y = "") + 
  theme_minimal() +
  geom_point(position = position_jitter(width = 0.2), size = 1.5, alpha = 0.5) +
  theme(plot.title = element_text(hjust = 0.5, size = 22), axis.title.x = element_text(size = 18), axis.title.y = element_text(size = 16),  axis.text.x = element_text(size = 18),  axis.text.y = element_text(size = 16),
  legend.position = "none") +
  annotate("text", x = 1, y = max(data_merged_FL$simpson), label = sprintf("p-value = %.4f", p_value_fls), hjust =-0.5, vjust = -0.5)

ggsave("simpson_FL.jpeg", plot = simpson_FL, width = 10, height = 6, dpi = 300)

# Perform Wilcoxon test for Simpson index for PA group
group_PA_A_S <- filter(data_merged_PA, Month == "April")$simpson
group_PA_J_S <-  filter(data_merged_PA, Month == "July")$simpson
wilcox_test_pa_s <- wilcox.test(group_PA_A_S, group_PA_J_S)
print(wilcox_test_pa_s)
p_value_pas <- round(wilcox_test_pa_s$p.value, 4)

# Create boxplot for Simpson index for PA group
simpson_PA <- ggplot(data_merged_PA, aes(x = Month, y = simpson)) + 
  geom_boxplot(aes(fill = Month), colour = "black") + 
  labs(title = "Simpson_PA", x = "", y = "") + 
  theme_minimal() +
  geom_point(position = position_jitter(width = 0.2), size = 1.5, alpha = 0.5) +
  theme(plot.title = element_text(hjust = 0.5, size = 22), axis.title.x = element_text(size = 18), axis.title.y = element_text(size = 16),  axis.text.x = element_text(size = 18), axis.text.y = element_text(size = 16),
  legend.position = "none") + 
  annotate("text", x = 1, y = max(data_merged_PA$simpson), label = sprintf("p-value = %.4f", p_value_pas), hjust = -0.5, vjust = -0.5)

ggsave("simpson_PA.jpeg", plot = simpson_PA, width = 10, height = 6, dpi = 300)


# Perform Wilcoxon test for ACE index for FL group
group_FL_A_ACE <- filter(data_merged_FL, Month == "April")$S.ACE
group_FL_J_ACE <-  filter(data_merged_FL, Month == "July")$S.ACE
wilcox_test_fl_ace <- wilcox.test(group_FL_A_ACE, group_FL_J_ACE)
print(wilcox_test_fl_ace)
p_value_fl_ace <- round(wilcox_test_fl_ace$p.value, 3)

# Create boxplot for ACE index for FL group
ace_FL <- ggplot(data_merged_FL, aes(x = Month, y = S.ACE)) + 
  geom_boxplot(aes(fill = Month), colour = "black") +
  labs(title = "ACE_FL", x = "", y = "Alpha diversity measure") + 
  theme_minimal() +
  geom_point(position = position_jitter(width = 0.2), size = 1.5, alpha = 0.5) +
  theme(plot.title = element_text(hjust = 0.5, size = 22), axis.title.x = element_text(size = 18), axis.title.y = element_text(size = 16),  axis.text.x = element_text(size = 18), axis.text.y = element_text(size = 16),
  legend.position = "none") +
  annotate("text", x = 1, y = max(data_merged_FL$S.ACE), label = sprintf("p-value = %.4f", p_value_fl_ace), hjust = -0.5, vjust = -0.5)
ggsave("ACE_FL.jpeg", plot = ace_FL, width = 10, height = 6, dpi = 300)

# Perform Wilcoxon test for ACE index for PA group
group_PA_A_ACE <- filter(data_merged_PA, Month == "April")$S.ACE
group_PA_J_ACE <-  filter(data_merged_PA, Month == "July")$S.ACE
wilcox_test_pa_ace <- wilcox.test(group_PA_A_ACE, group_PA_J_ACE)
print(wilcox_test_pa_ace)
p_value_pa_ace <- round(wilcox_test_pa_ace$p.value, 4)

# Create boxplot for ACE index for PA group
ace_PA <- ggplot(data_merged_PA, aes(x = Month, y = S.ACE)) + 
  geom_boxplot(aes(fill = Month), colour = "black") + 
  labs(title = "ACE_PA", x = "", y = "Alpha diversity measure") + 
  theme_minimal() +
  geom_point(position = position_jitter(width = 0.2), size = 1.5, alpha = 0.5) +
  theme(plot.title = element_text(hjust = 0.5, size = 22), axis.title.x = element_text(size = 18), axis.title.y = element_text(size = 16),  axis.text.x = element_text(size = 18),  axis.text.y = element_text(size = 16),
  legend.position = "none") +
  annotate("text", x = 1, y = max(data_merged_FL$S.ACE), label = sprintf("p-value = %.4f", p_value_pa_ace), hjust = -0.5, vjust = -0.5)
ggsave("ACE_PA.jpeg", plot = ace_PA, width = 10, height = 6, dpi = 300)

# Perform Wilcoxon test for Shannon index for FL group
group_FL_A_SN <- filter(data_merged_FL, Month == "April")$shannon
group_FL_J_SN <-  filter(data_merged_FL, Month == "July")$shannon
wilcox_test_fl_sn <- wilcox.test(group_FL_A_SN, group_FL_J_SN)
print(wilcox_test_fl_sn)
p_value_fl_sn <- round(wilcox_test_fl_sn$p.value, 4)

# Create boxplot for Shannon index for FL group
shannon_FL <- ggplot(data_merged_FL, aes(x = Month, y = shannon)) + 
  geom_boxplot(aes(fill = Month), colour = "black") +
  labs(title = "Shannon_FL", x = "", y = "") + 
  theme_minimal() +
  geom_point(position = position_jitter(width = 0.2), size = 1.5, alpha = 0.5) +
  theme(plot.title = element_text(hjust = 0.5, size = 22), axis.title.x = element_text(size = 18), axis.title.y = element_text(size = 16),  axis.text.x = element_text(size = 18),  axis.text.y = element_text(size = 16),
  legend.position = "none") +
  annotate("text", x = 1, y = max(data_merged_FL$shannon), label = sprintf("p-value = %.4f", p_value_fl_sn), hjust = -0.5, vjust = -0.5)
ggsave("shannon_FL.jpeg", plot = shannon_FL, width = 10, height = 6, dpi = 300)

# Perform Wilcoxon test for Shannon index for PA group
group_PA_A_SN <- filter(data_merged_PA, Month == "April")$shannon
group_PA_J_SN <-  filter(data_merged_PA, Month == "July")$shannon
wilcox_test_pa_sn <- wilcox.test(group_PA_A_SN, group_PA_J_SN)
print(wilcox_test_pa_sn)
p_value_pa_sn <- round(wilcox_test_pa_sn$p.value, 4)


# Create boxplot for Shannon index for PA group
shannon_PA <- ggplot(data_merged_PA, aes(x = Month, y = shannon)) + 
  geom_boxplot(aes(fill = Month), colour = "black") + 
  labs(title = "Shannon_PA", x = "", y = "") + 
  theme_minimal() +
  geom_point(position = position_jitter(width = 0.2), size = 1.5, alpha = 0.5) +
  theme(plot.title = element_text(hjust = 0.5, size = 22), axis.title.x = element_text(size = 18), axis.title.y = element_text(size = 16),  axis.text.x = element_text(size = 18), axis.text.y = element_text(size = 16),
  legend.position = "none") +
  annotate("text", x = 1, y = max(data_merged_PA$shannon), label = sprintf("p-value = %.4f", p_value_pa_sn), hjust = -0.5, vjust = -0.5)
ggsave("shannon_PA.jpeg", plot = shannon_PA, width = 10, height = 6, dpi = 300)


# Save combined plot
ggsave("combined_plot.jpeg", plot_grid(ace_PA, shannon_PA, simpson_PA, ace_FL, shannon_FL, simpson_FL, ncol = 3, align = 'none'), width = 10, height = 13, dpi = 300)



