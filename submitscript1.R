#Assigment 2

getwd()

setwd("C:/Users/aurquhart/Documents/Github/R_Programming_Assignment2")




#Point and download zip
dataset_url <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
download.file(dataset_url, "specdata.zip")

#unzip file
unzip("specdata.zip", exdir = "specdata")

#check files
list.files("specdata//specdata")

#So we're going to write a function to calculate the mean of 
#a field in the files - sulfate or nitrate

#Step 1 - test the loop to consolodate files

files <- list.files("specdata//specdata")
directory <- "specdata//specdata"
files_list <- list.files(directory, full.names=TRUE) #creates a list of files

dat <- data.frame() #creates an empty data frame

number_of_files <- length(files)

 
for (i in 1:number_of_files) { #loops through the files, rbinding them together
  dat <- rbind(dat, read.csv(files_list[i]))
}

#Now need to test that I can calculate the mean of the 2 fields

mean(dat[, "sulfate"], na.rm=TRUE) #identifies the mean weight
mean(dat[, "nitrate"], na.rm=TRUE) #identifies the mean weight

#head(dat)


#Now put it all into a function


pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)

  dat <- data.frame() #creates an empty data frame
  files_list <- list.files(directory, full.names=TRUE) #creates a list of files
  
  for (i in id) { #loops through the files, rbinding them together
    dat <- rbind(dat, read.csv(files_list[i]))
  }
    
  mean(dat[, pollutant], na.rm=TRUE)
  
  
}

 pollutantmean("specdata","sulfate",id=1:5)






