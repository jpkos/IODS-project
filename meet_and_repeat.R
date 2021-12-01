#Jani Koskinen
#Data Wranglign for Chapter 6
#1.12.2021

#Load libraries
library(reshape2)
#Load data
BPRS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep=" ")
RATS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep="\t")
#Convert to long form using "melt" function from the reshape2 package
BPRS.melt <- melt(BPRS, id.vars=c("treatment", "subject"))
RATS.melt <- melt(RATS, id.vars=c("ID", "Group"))
#Rename columns
colnames(BPRS.melt) <- c("treatment", "subject", "week", "value")
colnames(RATS.melt) <- c("ID", "Group", "Time", "value")
#Convert categorical variables to factors
catcols.RATS <- c("ID", "Group", "Time")
catcols.BPRS <- c("treatment", "subject", "week")
BPRS.melt[catcols.BPRS] <- lapply(BPRS.melt[catcols.BPRS], factor)
RATS.melt[catcols.RATS] <- lapply(RATS.melt[catcols.RATS], factor)
#What is the difference between long and wide form data?
#In the long form, we have coerced the values from different weeks into one column
#This makes it easier to do many operations in R. For example, when fitting a model,
#we can use "week" or "time" as a variable in the formula, in order to investigate
#if the values change over time. The data for different subjects are grouped by week.
#Long form data can also be used easily when plotting, for example we can  use ggplot's
#facet_wrap functionality to create subplots of the values for each week, or for each participant per week.

#Let's print some descriptive numbers of the data
#structure:
str(RATS.melt)
str(BPRS.melt)
#dimensions:
dim(RATS.melt)
dim(BPRS.melt)
#RATS has 360 rows and 4 columns, BPRS has 176 rows and 4 columns. 

#Finally, save the data
write.csv(RATS.melt, "data/chapter5/RATS.csv")
write.csv(BPRS.melt, "data/chapter5/BPRS.csv")
