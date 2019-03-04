# utility code to reduce retyping in SO answer 
# https://stackoverflow.com/questions/53446800/r-switching-variables-into-observations 

library(tidyr)

sex <- rep(c("both","women","men"),16)
age <- rep(c(rep("all",3),rep("up to 17",3),rep("18 to 64",3),rep("65 and over",3)),4)
quarter <- c(rep("Q1",12),rep("Q2",12),rep("Q3",12),rep("Q4",12))
data.frame(sex,age,quarter) %>% unite(excelColNames) -> columnsData
thecol2 <- unlist(c("Country",columnsData["excelColNames"]))

compareData <- data.frame(theCols,thecol2)
all.equal(thecol2,theCols)