#
# formatting numbers in Kable
# https://stackoverflow.com/questions/55093178/how-to-format-all-numbers-in-a-table-in-r-using-kable/5509390 

library(knitr)
library(kableExtra)
x = c(1, 1, 1, 1, 1, 1, 1, 1, 1)
y = x/2
z = x/3

a = data.frame(x=format(x,digits=4,nsmall = 0), 
               y = format(y,digits=4,nsmall = 0), 
               z = format(z,digits = 4,nsmall = 0))
b = t(a)
c = kable(b, "html", align = "c") %>%
  kable_styling(full_width = F)

# tidyverse alternative
library(knitr)
library(kableExtra)
library(dplyr)
x = c(1, 1, 1, 1, 1, 1, 1, 1, 1)
y = x/2
z = x/3
data.frame(x,y,z) %>% 
   mutate_if(is.numeric, format, digits=4,nsmall = 0) %>% t(.) %>% kable(.,"html",align = "c") %>% 
   kable_styling(full_width = F) -> c