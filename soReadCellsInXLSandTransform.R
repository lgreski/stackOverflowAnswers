#
# SO question about reading specific components of XLSX file
# https://stackoverflow.com/questions/53446800/r-switching-variables-into-observations 
#

# set location of XLSX file 
theXLSX <- "./data/soQuestion53446800.xlsx"

# download file from github to make script completely reproducible

sourceFile <- "https://raw.githubusercontent.com/lgreski/stackoverflowanswers/master/data/soQuestion53446800.xlsx"
destinationFile <- "./soQuestion53446800.xlsx"
download.file(sourceFile,destinationFile,mode="wb")


library(readxl)
library(tidyr)

# set constants 
typeOfLeave <- "sick"
group <- "self employed"
year <- "2018"

# setup column names using underscore so we can separate key column into Sex, Age, and Quarter columns 
# after using rep() to build data with required repeating patterns, avoiding manual typing of all the column names 
sex <- rep(c("both","women","men"),16)
age <- rep(c(rep("all",3),rep("up to 17",3),rep("18 to 64",3),rep("65 and over",3)),4)
quarter <- c(rep("Q1",12),rep("Q2",12),rep("Q3",12),rep("Q4",12))
data.frame(sex,age,quarter) %>% unite(excelColNames) -> columnsData
theCols <- unlist(c("Country",columnsData["excelColNames"]))

# read data with readxl::read_excel() 
theData <- read_excel(destinationFile,sheet=year,range="A5:AW9",col_names=theCols)

# use tidyr / dplyr to transform the data
theData %>% gather(.,key="key",value="Amount",2:49) %>% separate(.,key,into=c("Sex","Age","Quarter"),sep="_") -> tidyData

# assign constants

tidyData$typeOfLeave <- typeOfLeave
tidyData$group <- group
tidyData$year <- year

tidyData 

# read second worksheet to illustrate multiple reads 

# set constants 
typeOfLeave <- "sick"
group <- "self employed"
year <- "2017"

theData <- read_excel(destinationFile,sheet=year,range="A5:AW9",col_names=theCols)

# use tidyr / dplyr to transform the data
theData %>% gather(.,key="key",value="Amount",2:49) %>% separate(.,key,into=c("Sex","Age","Quarter"),sep="_") -> tidyData

# assign constants

tidyData$typeOfLeave <- typeOfLeave
tidyData$group <- group
tidyData$year <- year

tidyData 


## version that combines multiple years into a single narrow format tidy data file
# download file from github to make script completely reproducible

sourceFile <- "https://raw.githubusercontent.com/lgreski/stackoverflowanswers/master/data/soQuestion53446800.xlsx"
destinationFile <- "./soQuestion53446800.xlsx"
download.file(sourceFile,destinationFile,mode="wb")


library(readxl)
library(tidyr)

# set constants
years <- c("2017","2018")
typeOfLeave <- "sick"
group <- "self employed"

# setup column names using underscore so we can separate key column into Sex, Age, and Quarter columns 
# after using rep() to build data with required repeating patterns, avoiding manual typing of all the column names 
sex <- rep(c("both","women","men"),16)
age <- rep(c(rep("all",3),rep("up to 17",3),rep("18 to 64",3),rep("65 and over",3)),4)
quarter <- c(rep("Q1",12),rep("Q2",12),rep("Q3",12),rep("Q4",12))
data.frame(sex,age,quarter) %>% unite(excelColNames) -> columnsData
theCols <- unlist(c("Country",columnsData["excelColNames"]))


lapply(years,function(x){
  theData <- read_excel(destinationFile,sheet=x,range="A5:AW9",col_names=theCols)
  
  # use tidyr / dplyr to transform the data
  theData %>% gather(.,key="key",value="Amount",2:49) %>% separate(.,key,into=c("Sex","Age","Quarter"),sep="_") -> tidyData
  
  # assign constants
  
  tidyData$typeOfLeave <- typeOfLeave
  tidyData$group <- group
  tidyData$year <- x
  
  tidyData
}) %>% do.call(rbind,.) -> combinedData

head(combinedData)
tail(combinedData)


