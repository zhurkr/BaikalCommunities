#расчет показателей видового разнообразия 

library(tibble)
library(vegan)
library(ggplot2)

#set working directory
setwd("D:/Baikal_v3/16S_275")

#Reading data
data_count<-read.csv("updated_BD.zotutab_filtr.txt", header=TRUE, sep="\t", check.names = FALSE)

#changes the order of columns 
data_count <- data_count[c(1, 10, 20, 31, 35:38, 2:9, 11:19, 21:30, 32:34)]

#renaming columns
colnames(data_count)[c( 2, 3, 4, 5, 6, 7, 8)] <- c("X01", "X02", "X03", "X04", "X05", "X06", "X07")
colnames(data_count)[2:38] <- c('V1UI-0-FL', 'V1UI-0-PA', 'V1UI-5-FL', 'V1UI-5-PA', 'V2UI-0-FL', 'V2UI-0-PA', 'V2UI-5-FL', 'V2UI-30-FL', 'V2UI-30-PA', 'V3UI-0-FL', 'V3UI-0-PA', 'V3UI-5-FL', 'V3UI-10-FL', 'V3UI-10-PA', 'V3UI-30-FL', 'V3UI-30-PA', 'V1PL-0-FL', 'V1PL-0-PA', 'V1PL-3-FL', 'V1PL-3-PA', 'V1PL-7-FL', 'V2PL-0-FL', 'V2PL-0-PA', 'V2PL-5-FL', 'V2PL-5-PA', 'V2PL-10-FL', 'V2PL-10-PA', 'V2PL-30-FL', 'V2PL-30-PA', 'V3PL-0-FL', 'V3PL-0-PA', 'V3PL-5-FL', 'V3PL-5-PA', 'V3PL-10-FL', 'V3PL-10-PA', 'V3PL-30-FL', 'V3PL-30-PA')

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
