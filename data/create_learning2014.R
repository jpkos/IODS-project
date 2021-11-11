#Jani Koskinen
#11.11.2021
#Linear regression files
#
library(dplyr)
#read data
data <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
#print dimensions (rows and columns) and describe the structure
dim(data)
str(data)
#Combine variables
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_columns <- select(data, one_of(deep_questions))
data$deep <- rowMeans(deep_columns)
surface_columns <- select(data, one_of(surface_questions))
data$surf <- rowMeans(surface_columns)
strategic_columns <- select(data, one_of(strategic_questions))
data$stra <- rowMeans(strategic_columns)
#Check struct again
str(data)
#Filter observations where exam points zero
data <- filter(data, Points>0)
#Save as csv
write.csv(data, "data/learning2014_csv.csv")
#read data
new_read <- read.csv("data/learning2014_csv.csv")
#Print dimensions as test
dim(new_read)
#Seems to work!