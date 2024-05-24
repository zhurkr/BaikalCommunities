

# Load the necessary library
library(vegan)

# Set the working directory to the specified path
setwd("D:/Baikal_v3/16S_275")

# Read the CSV file into a data frame
data_count<-read.csv("updated_BD.zotutab_filtr.txt", header=TRUE, sep="\t", check.names = FALSE)

# Rearrange the columns in a specified order
data_count <- data_count[c(1, 10, 20, 31, 35:38, 2:9, 11:19, 21:30, 32:34)]

# Rename columns
colnames(data_count)[c( 2, 3, 4, 5, 6, 7, 8)] <- c("X01", "X02", "X03", "X04", "X05", "X06", "X07")
colnames(data_count)[2:38] <- c('V1UI-0-FL', 'V1UI-0-PA', 'V1UI-5-FL', 'V1UI-5-PA', 'V2UI-0-FL', 'V2UI-0-PA', 'V2UI-5-FL', 'V2UI-30-FL', 'V2UI-30-PA', 'V3UI-0-FL', 'V3UI-0-PA', 'V3UI-5-FL', 'V3UI-10-FL', 'V3UI-10-PA', 'V3UI-30-FL', 'V3UI-30-PA', 'V1PL-0-FL', 'V1PL-0-PA', 'V1PL-3-FL', 'V1PL-3-PA', 'V1PL-7-FL', 'V2PL-0-FL', 'V2PL-0-PA', 'V2PL-5-FL', 'V2PL-5-PA', 'V2PL-10-FL', 'V2PL-10-PA', 'V2PL-30-FL', 'V2PL-30-PA', 'V3PL-0-FL', 'V3PL-0-PA', 'V3PL-5-FL', 'V3PL-5-PA', 'V3PL-10-FL', 'V3PL-10-PA', 'V3PL-30-FL', 'V3PL-30-PA')

# Identify the columns containing "FL" in their names
fl_columns <- grep("FL", names(data_count))

# Identify the columns containing "PA" in their names
pa_columns <- grep("PA", names(data_count))

# Identify the remaining columns
other_columns <- setdiff(seq_along(data_count), c(fl_columns, pa_columns))

# Reorder the columns: first other columns, then FL columns, then PA columns
sorted_data_count <- data_count[, c(other_columns, fl_columns, pa_columns)]

# Split the data into two data frames: one for FL columns and one for PA columns
data_count_FL <- sorted_data_count[c(1:21)]
data_count_PA <- sorted_data_count[c(1, 22:38)] 

# Set the row names for data_count_FL and remove the first column
rownames(data_count_FL)<-data_count_FL[,1]
data_count_FL<-data_count_FL[,-1]

# Set the row names for data_count_PA and remove the first column
rownames(data_count_PA)<-data_count_PA[,1]
data_count_PA<-data_count_PA[,-1]

# Generate rarefaction curves for the FL data
d_f_FL<-as.data.frame(t(data_count_FL))
rc_fl<-rarecurve(d_f_FL, step = 20, sample=70, col = "blue", cex=0.4)

# Generate rarefaction curves for the PA data
d_f_PA<-as.data.frame(t(data_count_PA))
rc_pa<-rarecurve(d_f_PA, step = 20, sample=70, col = "blue", cex=0.4)
