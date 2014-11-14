complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  dat <- data.frame() #creates an empty data frame
  files_list <- list.files(directory, full.names=TRUE) #creates a list of files
  
  for (i in id) { #loops through the files, rbinding them together
    dat <- rbind(dat, read.csv(files_list[i]))
  }
  
  dat <- dat[complete.cases(dat),] #Remove NA rows
  aggregate(sulfate ~ ID, dat,length) #Count and group by ID
  
}





#Assigment 2.3

getwd()

setwd("C:/Users/angus/Documents/Github/R_Programming_Assignment2")


#Point and download zip
dataset_url <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
download.file(dataset_url, "specdata.zip")

#unzip file
unzip("specdata.zip", exdir = "specdata")

#check files
list.files("specdata")


directory <- "specdata" # mimic function - we'll use directory as a variable
files_list <- list.files(directory, full.names=TRUE)  # get the full names of file in 'directory'
dat <- data.frame() #creates an empty data frame

for (i in 1:2) { #loops through the files, rbinding them together
  dat <- rbind(dat, read.csv(files_list[i]))
}

#head(dat)  tail(dat)

dat_non_na <- dat[complete.cases(dat),] #Remove NA rows
dat_non_na_group <- aggregate(sulfate ~ ID, dat_non_na,length) #Count valid records for each ID

answer_set <- merge(dat_non_na,dat_non_na_group,by.x = "ID", by.y = "ID") #now join them back on

threshold = 0
#now filter the number of valid records based on a setting e.g. 200 should filter 1 and leave 1

for_correl <- answer_set[answer_set$sulfate.y>threshold,]
#-0.01895754

head(for_correl)
tail(for_correl)

result <- by(for_correl[,3:4], for_correl$sulfate.y, function(x) {cor(x$sulfate.x, x$nitrate)})
#class(result)


result.dataframe <- as.data.frame(as.matrix(result))


avector <- result.dataframe[,1]


# Add the group column from the row names
#result.dataframe$C <- rownames(result)





#cor(for_correl$sulfate.x,for_correl$nitrate)



