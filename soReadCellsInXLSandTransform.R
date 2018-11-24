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

# read date and extract the value
theDate <- read_excel(destinationFile,range="A2:A2",col_names=FALSE)[[1]]

# setup column names using underscore so we can separate key column into Sex and Age columns 
theCols <- c("Country","both_all","women_all","men_all","both_up to 17","women_up to 17","men_up to 17")
theData <- read_excel(destinationFile,range="A5:G9",col_names=theCols)

# use tidyr / dplyr to transform the data
theData %>% gather(.,key="key",value="Amount",2:7) %>% separate(.,key,into=c("Sex","Age"),sep="_") -> tidyData

# assign constants

tidyData$typeOfLeave <- typeOfLeave
tidyData$group <- group
tidyData$date <- theDate

tidyData 