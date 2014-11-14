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
  answer <- aggregate(sulfate ~ ID, dat,length) #Count and group by ID
  names(answer)[names(answer)=="sulfate"] <- "nobs"
  return(answer)
}

#complete("specdata", 3)
#complete("specdata", c(2, 4, 8, 10, 12))


#complete("specdata", 1)

#?aggregate