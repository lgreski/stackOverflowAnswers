#
# https://stackoverflow.com/questions/53470107/splitting-data-and-then-performing-rbind/53470166#53470166
# 

library(tidyr)
rawData <- "11,50,2,7,23,10"
colNames <- c("Category 1","Category 2","Category 3","Category 4","Category 5","Category 6")

data <- read.csv(text=rawData,header=FALSE)

colnames(data) <- colNames

data %>% gather(.) -> tidyData

tidyData