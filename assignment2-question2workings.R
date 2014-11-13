#Assigment 2 Question 2 workings


getwd()

setwd("C:/Users/aurquhart/Documents/Github/R_Programming_Assignment2")


#check files
list.files("specdata")

directory <- "specdata"
files_list <- list.files(directory, full.names=TRUE) 

dat <- data.frame() #creates an empty data frame
dat1 <- data.frame() #creates an empty data frame
number_of_files <- length(files)



for (i in 1:2) { #loops through the files, rbinding them together
  dat <- rbind(dat, read.csv(files_list[i]))
}


#head(dat)

dat1 <- dat[complete.cases(dat),]

head(dat1)
tail(dat1)

?aggregate

aggregate(sulfate ~ ID, dat1,length)

length(dat1)

class(dat1)
nrow(dat1)

dat <- dat

dat1 <- with(dat, sulfate != "NA")


length(dat$sulfate)


?length