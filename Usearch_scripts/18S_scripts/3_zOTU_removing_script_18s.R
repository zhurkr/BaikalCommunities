library(dplyr)
library(tibble)
library(seqinr)

#set working directory
setwd("D:/Baikal_v3/18S_275")

#reading data
data<-read.csv("BD.zotutab_filtr.txt",header=TRUE,sep="\t")
data$all <-  rowSums(data[, sapply(data, is.numeric)], na.rm = TRUE)

sorted_data <- data %>%
  arrange(desc(all))

head(sorted_data$X.OTU.ID, 21)

data_tax<-read.csv("BD.z_sintax_filtr.txt",header=F,sep="\t")
#[1] "Zotu3"   "Zotu4"   "Zotu7"   "Zotu5"   "Zotu6"   "Zotu11"  "Zotu8"   "Zotu9"   "Zotu14" 
#[10] "Zotu10"  "Zotu12"  "Zotu13"  "Zotu20"  "Zotu15"  "Zotu17"  "Zotu18"  "Zotu16"  "Zotu29" 
#[19] "Zotu637" "Zotu19"


data_new <-read.csv("BD.zotutab_filtr.txt",header=TRUE,sep="\t")
data_new <- data_new[data_new$X.OTU.ID != "Zotu21",]
write.table(data_new, "updated_BD.zotutab_filtr.txt", quote=F, row.names=F, col.names=T, sep = "\t") 


data_tax_new <-read.csv("BD.z_sintax_filtr.txt",header=F,sep="\t")
data_tax_new <- data_tax_new[data_tax_new$V1 != "zOTU21",]
write.table(data_tax_new, "updated_BD.z_sintax_filtr.txt", quote=F, row.names=F, col.names=F, sep = "\t")

pas_new <-read.fasta("BD.zotus_filtr.fa")
# Извлечение имен последовательностей
names <- names(pas_new)
# Исключение последовательности с именем "Zotu21"
pas_new <- pas_new[!names %in% "Zotu21"]
# Сохранение изменённого FASTA файла, если нужно
write.fasta(sequences = pas_new, names = names(pas_new), file.out = "updated_BD.zotus_filtr.fa")

