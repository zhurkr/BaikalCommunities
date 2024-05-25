library(tibble)
library(vegan)
library(ggplot2)

#set working directory
setwd("D:/Baikal_v3/18S_275")

#Reading data
data_count<-read.csv("BD.zotutab_filtr.txt", header=TRUE, sep="\t", check.names = FALSE)

#Setting the first column as row names
rownames(data_count)<-data_count[,1]
data_count<-data_count[,-1]

#Data transposition and converting the matrix to a Data Frame
d_f<-as.data.frame(t(data_count))

#Species diversity assessment
diversiti<-t(estimateR(d_f))
shannon<-diversity(d_f, index = "shannon")
simpson<-diversity(d_f, index = "simpson")
diversiti<-cbind(sample_id=rownames(diversiti), reads_number=rowSums(d_f),diversiti,  shannon=shannon, simpson=simpson)
diversiti<-as.data.frame(diversiti)

write.table(diversiti, "bac_z_diversity.txt", quote=F, sep="\t", row.names=F)
