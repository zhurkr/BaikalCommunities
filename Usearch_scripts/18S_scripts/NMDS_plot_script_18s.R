library(vegan)
library(ggplot2)

#set working directory
setwd("D:/Baikal_v3/18S_275")

#Reading data
data_count <- read.csv("BD.zotutab_filtr.txt", header=TRUE, sep="\t", check.names = FALSE)

#Setting the first column as row names
rownames(data_count) <- data_count[,1]
data_count <- data_count[,-1]

#changes the order of columns in data_count
data_count <- data_count[c(9, 17:20, 1:8, 10:16)]

#renaming columns
colnames(data_count)[c(1:20)] <- c('UW1/0_5','UW1/5_5','UW2/0_5', 'UW2/5_5', 'UW2/10_5', 'UW3/0_5', 'UW3/5_5', 'UW3/10_5', 'UW3/30_5', 'PL1/0_5', 'PL1/3_5', 'PL1/7_5', 'PL2/0_5', 'PL2/5_5', 'PL2/10_5', 'PL2/30_5', 'PL3/0_5', 'PL3/5_5', 'PL3/10_5', 'PL3/30_5')

#Data transposition
data_count_t <- t(data_count)

#Construction NMDS
nmds <- metaMDS(data_count_t, distance = "bray", k = 2)  # Используем расстояние Брея-Кёртиса и 2 измерения

# Visualisation of NMDS
plot(nmds, type = "n")  #Basic plot
points(nmds, col = "blue")   #Add points
text(nmds$points, labels = rownames(nmds$points), pos = 3, cex = 0.5)  #Add labels

#Improve visualization with ggplot2
df_nmds <- as.data.frame(nmds$points)
df_nmds$labels <- rownames(df_nmds)

NMDS_18s_275 <- ggplot(df_nmds, aes(x = MDS1, y = MDS2, label = labels)) +
  geom_point(colour = "blue") +
  geom_text(vjust = 1.5, hjust = 0.5, size = 2) +
  theme_minimal() +
  labs(x = "NMDS Dim 1", y = "NMDS Dim 2", title = "NMDS Plot of microeukariotic Community 275")

#Save the image
ggsave("NMDS_18s_275.jpeg", plot = NMDS_18s_275, width = 10, height = 6, dpi = 300)

