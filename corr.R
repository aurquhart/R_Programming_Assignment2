corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  files_list <- list.files(directory, full.names=TRUE)  # get the full names of file in 'directory'
  number_of_files <- length(files_list)
  dat <- data.frame() #creates an empty data frame
  
  for (i in 1:number_of_files) { #loops through the files, rbinding them together
    dat <- rbind(dat, read.csv(files_list[i]))
  }
  
  
  dat_non_na <- dat[complete.cases(dat),] #Remove NA rows
  dat_non_na_group <- aggregate(sulfate ~ ID, dat_non_na,length) #Count valid records for each ID
  answer_set <- merge(dat_non_na,dat_non_na_group,by.x = "ID", by.y = "ID") #now join them back on
  
  for_correl <- answer_set[answer_set$sulfate.y>threshold,] #now filter based on threshold
  result <- by(for_correl[,3:4], for_correl$sulfate.y, function(x) {cor(x$sulfate.x, x$nitrate)}) #do correlations
  result.dataframe <- as.data.frame(as.matrix(result)) #convery to df
  result.dataframe[,1] #return vector of numbers
  
}