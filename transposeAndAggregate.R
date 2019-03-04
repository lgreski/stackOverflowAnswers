#
# column means in R with csv
# https://stackoverflow.com/questions/54967543/column-mean-in-r-using-csv-file

rawData <- "Serial No.,7209,7209,7208,7208,7208,7208
W1,3,1,1,2,1,5
W2,6,3,3,4,4,7
W3,9,5,5,6,7,9
W4,12,7,7,8,10,11
W5,15,9,9,10,13,13
W6,18,11,11,12,16,15
W7,21,13,13,14,19,17
W8,24,15,15,16,22,19"

data <- read.csv(text=rawData,header=FALSE,stringsAsFactors=FALSE)

# transpose columns 2 - n

xpose <- as.data.frame(t(data[,2:ncol(data)]))

# set names to first column of original data, first cleaning column  names
names(xpose) <- make.names(data$V1,unique = TRUE)

# convert to narrow format tidy data
library(tidyr)
library(dplyr)
xpose %>% group_by(Serial.No.) %>% gather(key = key,value = value,-Serial.No.) %>% summarise(mean = mean(value)) %>%
  as.data.frame(.)

# manual cross check

# mean of 7208 data
mean(unlist(lapply(4:7,function(x){data[2:nrow(data),x]})))

# mean of 7209 data
mean(unlist(lapply(2:3,function(x){data[2:nrow(data),x]})))