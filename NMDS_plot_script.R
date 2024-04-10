library(vegan)
library(ggplot2)

data_count<-read.csv("BD.zotutab_filtr_sorted.txt", header=TRUE, sep="\t", check.names = FALSE)

rownames(data_count)<-data_count[,1]
data_count<-data_count[,-1]

#transpose
data_count_t <- t(data_count)

NMDS=metaMDS(data_count_t, # сommunity-by-species matrix
             k=2)

tiff("nmds_plot.jpeg", width = 800, height = 600, units = "px")

plot(NMDS)
ordiplot(NMDS, type="n")

# Добавление точек для образцов, увеличив размер точек для лучшей видимости
orditorp(NMDS, display="sites", pch=5, col="blue", cex=0.6, air=0.01)

dev.off()
