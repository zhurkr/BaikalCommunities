library(tibble)
library(seqinr)
Sys.setlocale("LC_CTYPE", "russian")

#set working directory
setwd("D:/Baikal_v3/16S_275")

#removing chloroplast

#reading data
data<-read.csv("BD.zotutab.txt",header=TRUE,sep="\t")
data_tax<-read.csv("BD.z_sintax.txt",header=F,sep="\t")

#creating a vector with 2 column taxonomy
tax_line<-data_tax[,2]

#obtaining line numbers and OTU IDs with chloroplast sequences
n<-which(grepl("c:Chloroplast", tax_line))
otu_id<-data_tax[,1]
otu_id<-otu_id[n]

#obtaining row numbers with chloroplast sequences in the representation table
n_table<-which(data[,1] %in% otu_id)

#removing chloroplast sequences from representation table and taxonomy table
data<-data[-n_table,]
data_tax<-data_tax[-n,]

#writing filtered tables
write.table(data, "BD.zotutab_filtr.txt", quote=F, row.names=F, col.names=T, sep = "\t") 
write.table(data_tax, "BD.z_sintax_filtr.txt", quote=F, row.names=F, col.names=F, sep = "\t")

#sequence reading
pas<-read.fasta("BD.zotus.fa")
pas_names<-names(pas)

#removing chloroplast sequences from sequences
n<-which(pas_names %in% otu_id)
pas<-pas[-n]

#recording of filtered representative sequences
write.fasta(pas, names=names(pas), file.out="BD.zotus_filtr.fa", nbchar=800)

