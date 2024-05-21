#devtools::install_github("tpq/balance")
library(tibble)
library(vegan)
library(ggplot2)
library(readxl)
library(RColorBrewer)
library(dplyr)
library(tidyr)
library(openxlsx)


setwd("C:/Users/zhurk/bioinfo2023_2024/Baikal")

data_count<-read.csv("BD.zotutab_filtr_sorted.txt", header=TRUE, sep="\t", check.names = FALSE)
rownames(data_count)<-data_count[,1]
data_count<-data_count[,-1]

data_alpha <-read.csv("bac_z_diversity.txt", header=TRUE, sep="\t", check.names = FALSE)
#bac_z_diversity.txt from vegan package

metadata <- read_excel("Metadata_modified.xlsx", col_names = TRUE)
data_merged <- merge(data_alpha, metadata, by = "sample")


#Боксплоты

chao1 <- ggplot(data_merged, aes(x = Lifestyle, y = S.chao1)) + 
  geom_boxplot(aes(colour = Lifestyle)) + 
  labs(title = "chao", x = "Lifestyle", y = "Alpha diversity measure") + 
  theme_minimal() +
  geom_point(position = position_jitter(width = 0.2), size = 1.5, alpha = 0.5) +
  theme(plot.title = element_text(hjust = 0.5, size = 30), axis.title.x = element_text(size = 25), axis.title.y = element_text(size = 25), axis.text.x = element_text(size = 25))
ggsave("chao1.jpeg", plot = chao1, width = 10, height = 6, dpi = 300)


ace <- ggplot(data_merged, aes(x = Lifestyle, y = S.ACE)) + 
  geom_boxplot(aes(colour = Lifestyle)) + 
  labs(title = "ACE", x = "Lifestyle", y = "Alpha diversity measure") + 
  theme_minimal() +
  geom_point(position = position_jitter(width = 0.2), size = 1.5, alpha = 0.5) +
  theme(plot.title = element_text(hjust = 0.5, size = 30), axis.title.x = element_text(size = 25), axis.title.y = element_text(size = 25), axis.text.x = element_text(size = 25))
ggsave("ACE.jpeg", plot = ace, width = 10, height = 6, dpi = 300)


simpson <- ggplot(data_merged, aes(x = Lifestyle, y = simpson)) + 
  geom_boxplot(aes(colour = Lifestyle)) + 
  labs(title = "simpson", x = "Lifestyle", y = "Alpha diversity measure") + 
  theme_minimal() +
  geom_point(position = position_jitter(width = 0.2), size = 1.5, alpha = 0.5) +
  theme(plot.title = element_text(hjust = 0.5, size = 30), axis.title.x = element_text(size = 25), axis.title.y = element_text(size = 25), axis.text.x = element_text(size = 25))
ggsave("simpson.jpeg", plot = simpson, width = 10, height = 6, dpi = 300)


shannon <- ggplot(data_merged, aes(x = Lifestyle, y = shannon)) + 
  geom_boxplot(aes(colour = Lifestyle)) + 
  labs(title = "shannon", x = "Lifestyle", y = "Alpha diversity measure") + 
  theme_minimal() +
  geom_point(position = position_jitter(width = 0.2), size = 1.5, alpha = 0.5) +
  theme(plot.title = element_text(hjust = 0.5, size = 30), axis.title.x = element_text(size = 25), axis.title.y = element_text(size = 25), axis.text.x = element_text(size = 25))
ggsave("shannon.jpeg", plot = shannon, width = 10, height = 6, dpi = 300)
