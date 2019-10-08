#
# SO question
# https://stackoverflow.com/questions/58176322/reading-in-txt-files-from-a-directory-using-r 

# two design considerations
# 1. header row is missing a value for the first column, which causes R file read functions to fail.
#    requires a solution that combines data with correct column names
# 2. combining files after they're read

theFiles <- list.files("./data",pattern="so5817*",full.names = TRUE)

# list the files
theFiles

library(readr)

# read header row, add "location" and save to vector

columnData <- read_csv(theFiles[1],col_names = FALSE,n_max = 1)
columnNames <- unlist(c("location",as.vector(columnData[1,])))

# read raw data

data <- read_csv(theFiles[1],col_names = FALSE,skip = 1)

# add headings to data
colnames(data) <- columnNames 

data

# read raw data from multiple files
# 
# assume that all files have the same column names, which is inferred from OP
# 

theData <- lapply(theFiles,function(x){read_csv(theFiles[1],col_names = FALSE,skip = 1)})

# at this point, theData is a list that contains two data frames
# we can now combine the data frames with rbind() and add the column names

combinedData <- do.call(rbind,theData)
colnames(combinedData) <- columnNames
combinedData

# enhanced version that tracks the file name from which the data was loaded

theData <- lapply(theFiles,function(x){
  y<- read_csv(theFiles[1],col_names = FALSE,skip = 1)
  # add a column for source file name
  y$sourceFile <- x
  y})

# at this point, theData is a list that contains two data frames
# we can now combine the data frames with rbind() and add the column names

combinedData <- do.call(rbind,theData)
colnames(combinedData) <- c(columnNames,"sourceFile")
combinedData