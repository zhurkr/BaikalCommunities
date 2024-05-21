library(vegan)
library(ggplot2)

#set working directory
setwd("D:/Baikal_v3/16S_275")

#Reading data
data_count <- read.csv("updated_BD.zotutab_filtr.txt", header=TRUE, sep="\t", check.names = FALSE)

#changes the order of columns in data_count
data_count <- data_count[c(1, 10, 20, 31, 35:38, 2:9, 11:19, 21:30, 32:34)]

#renaming columns
colnames(data_count)[c( 2, 3, 4, 5, 6, 7, 8)] <- c("X01", "X02", "X03", "X04", "X05", "X06", "X07")
colnames(data_count)[2:38] <- c('V1UI-0-FL', 'V1UI-0-PA', 'V1UI-5-FL', 'V1UI-5-PA', 'V2UI-0-FL', 'V2UI-0-PA', 'V2UI-5-FL', 'V2UI-30-FL', 'V2UI-30-PA', 'V3UI-0-FL', 'V3UI-0-PA', 'V3UI-5-FL', 'V3UI-10-FL', 'V3UI-10-PA', 'V3UI-30-FL', 'V3UI-30-PA', 'V1PL-0-FL', 'V1PL-0-PA', 'V1PL-3-FL', 'V1PL-3-PA', 'V1PL-7-FL', 'V2PL-0-FL', 'V2PL-0-PA', 'V2PL-5-FL', 'V2PL-5-PA', 'V2PL-10-FL', 'V2PL-10-PA', 'V2PL-30-FL', 'V2PL-30-PA', 'V3PL-0-FL', 'V3PL-0-PA', 'V3PL-5-FL', 'V3PL-5-PA', 'V3PL-10-FL', 'V3PL-10-PA', 'V3PL-30-FL', 'V3PL-30-PA')

#Setting the first column as row names
rownames(data_count) <- data_count[,1]
data_count <- data_count[,-1]

#Data transposition
data_count_t <- t(data_count)

#Construction NMDS
nmds <- metaMDS(data_count_t, distance = "bray", k = 2)  #Используем расстояние Брея-Кёртиса и 2 измерения

# Visualisation of NMDS
plot(nmds, type = "n")  #Basic plot
points(nmds, col = "blue")  #Add points
text(nmds$points, labels = rownames(nmds$points), pos = 3, cex = 0.4)  #Add labels

#Improve visualization with ggplot2
df_nmds <- as.data.frame(nmds$points)
df_nmds$labels <- rownames(df_nmds)

NMDS_16s_275 <- ggplot(df_nmds, aes(x = MDS1, y = MDS2, label = labels)) +
  geom_point(colour = "blue") +
  geom_text(vjust = 1.5, hjust = 0.5, size = 2) +
  theme_minimal() +
  labs(x = "NMDS Dim 1", y = "NMDS Dim 2", title = "NMDS Plot of FL and PA bacterial Community")

#Save the image
ggsave("NMDS_16s_275.jpeg", plot = NMDS_16s_275, width = 10, height = 6, dpi = 300)

