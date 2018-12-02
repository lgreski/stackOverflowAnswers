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
theCols <- c("Country","both_all_Q1","women_all_Q1","men_all_Q1","both_up to 17_Q1","women_up to 17_Q1","men_up to 17_Q1",
             "both_18 to 64_Q1","women_18 to 64_Q1","men_18 to 64_Q1",
             "both_65 and over_Q1","women_65 and over_Q1","men_65 and over_Q1",
             "both_all_Q2","women_all_Q2","men_all_Q2","both_up to 17_Q2","women_up to 17_Q2","men_up to 17_Q2",
             "both_18 to 64_Q2","women_18 to 64_Q2","men_18 to 64_Q2",
             "both_65 and over_Q2","women_65 and over_Q2","men_65 and over_Q2",
             "both_all_Q3","women_all_Q3","men_all_Q3","both_up to 17_Q3","women_up to 17_Q3","men_up to 17_Q3",
             "both_18 to 64_Q3","women_18 to 64_Q3","men_18 to 64_Q3",
             "both_65 and over_Q3","women_65 and over_Q3","men_65 and over_Q3",
             "both_all_Q4","women_all_Q4","men_all_Q4","both_up to 17_Q4","women_up to 17_Q4","men_up to 17_Q4",
             "both_18 to 64_Q4","women_18 to 64_Q4","men_18 to 64_Q4",
             "both_65 and over_Q4","women_65 and over_Q4","men_65 and over_Q4")
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

