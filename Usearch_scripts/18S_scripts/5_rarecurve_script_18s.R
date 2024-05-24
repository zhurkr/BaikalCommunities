# Load the necessary library
library(vegan)

# Set the working directory 
setwd("D:/Baikal_v3/18S_275")

# Read the CSV file
data_count<-read.csv("BD.zotutab_filtr.txt", header=TRUE, sep="\t", check.names = FALSE)

# Set the row names and remove the first column
rownames(data_count)<-data_count[,1]
data_count<-data_count[,-1]

# Generate rarefaction curves
d_f<-as.data.frame(t(data_count))
rc<-rarecurve(d_f, step = 20, sample=70, col = "blue", cex=0.4)
