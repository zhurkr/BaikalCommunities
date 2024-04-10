#расчет показателей видового разнообразия 

library(tibble)
library(vegan)
library(ggplot2)

setwd("C:/Users/zhurk/bioinfo2023_2024/Baikal")


data_count<-read.csv("BD.zotutab_filtr_sorted.txt", header=TRUE, sep="\t", check.names = FALSE)
rownames(data_count)<-data_count[,1]
data_count<-data_count[,-1]

d_f<-as.data.frame(t(data_count))

#оценка видового разнообразия
diversiti<-t(estimateR(d_f))
shannon<-diversity(d_f, index = "shannon")
simpson<-diversity(d_f, index = "simpson")
diversiti<-cbind(sample_id=rownames(diversiti), reads_number=rowSums(d_f),diversiti,  shannon=shannon, simpson=simpson)
diversiti<-as.data.frame(diversiti)
write.table(diversiti, "bac_z_diversity.txt", quote=F, sep="\t", row.names=F)
