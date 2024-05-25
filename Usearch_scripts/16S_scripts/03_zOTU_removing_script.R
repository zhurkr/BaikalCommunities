library(dplyr)
library(tibble)
library(seqinr)


setwd("D:/Baikal_v3/16S_275")

#reading data
data<-read.csv("BD.zotutab_filtr.txt",header=TRUE,sep="\t")
data$all <-  rowSums(data[, sapply(data, is.numeric)], na.rm = TRUE)
sorted_data <- data %>%
  arrange(desc(all))

head(sorted_data$X.OTU.ID, 20)

data_tax<-read.csv("BD.z_sintax_filtr.txt",header=F,sep="\t")
#[1] "Zotu2"  "Zotu3"  "Zotu5"  "Zotu6"  "Zotu7"  "Zotu12" "Zotu11" "Zotu13" "Zotu15" "Zotu14" "Zotu17"
#[12] "Zotu25" "Zotu19" "Zotu20" "Zotu28" "Zotu27" "Zotu23" "Zotu26" "Zotu21" "Zotu29"


#removing Zotu21 d:Bacteria(1.0000),p:Verrucomicrobia(0.5800)

data_new <-read.csv("BD.zotutab_filtr.txt",header=TRUE,sep="\t")
data_new <- data_new[data_new$X.OTU.ID != "Zotu21",]
write.table(data_new, "updated_BD.zotutab_filtr.txt", quote=F, row.names=F, col.names=T, sep = "\t") 


data_tax_new <-read.csv("BD.z_sintax_filtr.txt",header=F,sep="\t")
data_tax_new <- data_tax_new[data_tax_new$V1 != "zOTU21",]
write.table(data_tax_new, "updated_BD.z_sintax_filtr.txt", quote=F, row.names=F, col.names=F, sep = "\t")

pas_new <-read.fasta("BD.zotus_filtr.fa")

# Extracting Sequence Names
names <- names(pas_new)

# Eliminate sequence named "Zotu21"
pas_new <- pas_new[!names %in% "Zotu21"]

#Saving the modified FASTA file if necessary
write.fasta(sequences = pas_new, names = names(pas_new), file.out = "updated_BD.zotus_filtr.fa")

