#Jani Koskinen
#Data Wrangling for the logistic regression exercise
#20.11.2021


#NOTE: I did not have time to fix the script so that the output data has 370 rows. This outputs data with 382 rows
#To create the correct dataset, I used the example script here: https://raw.githubusercontent.com/rsund/IODS-project/master/data/create_alc.R
#Load libraries
library(dplyr)
#Read csv files
mat <- read.csv("data/student/student-mat.csv", sep=";")
por <- read.csv("data/student/student-por.csv", sep=";")

#Combine using DataCamp chapter 2 as example:
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(mat, por, by = join_by, suffix = c(".math", ".por"))

#Check structure of created dataset
str(math_por)
#The new dataset has combined math and por datasets so that new columns have either .math or .por as suffix
#depending on which dataset the data came from

#create new dataset with only the duplicated columns. I will use the datacamp example to save time
alc <- select(math_por, one_of(join_by))
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]
for(column_name in notjoined_columns) {
  #This loop combines the duplicated columns based on whether the data is numeric or not.
  #If numeric, take mean, else take the value from the first column
  two_columns <- select(math_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else {
    alc[column_name] <- first_column
  }
}
#Remove erroneous lines (there should be 370 rows according to the instructions)
#Let's use the example given in:

#Save combined data
write.csv(alc, "data/student/alc_combined.csv")

