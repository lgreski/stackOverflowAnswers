# https://stackoverflow.com/questions/53454013/dry-when-enumerating-variables-in-r-for-multiple-operations-in-a-pipeline

library(tidyverse)
data(iris)
varList <- c("Sepal.Width","Species")
iris %>% arrange_(.dots=varList) %>% select_(.dots=varList)