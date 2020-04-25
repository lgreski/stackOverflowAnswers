#
# SO answer
#

# OP code
data1<- read.fwf("./data/data1.cur", widths = c(1, 5, 4, 5,4,6,1,5,13,3,34), skip = 1) # necessary because of the space limiting

data1<- data1[,c(2,4,6,8,9)] # then i select the coloums which i need and are resulting of the previous code nor NAs

colnames(data1) <- c("TempC", "value1", "value2", "value3", "value4") # then i give the columnames which I deleted in the first code line by skip=1, because they are not usable 

plot(data1$TempC, data1$value1, type="l") # here i check if everything worked - yes it does 

max<- subset(data1,data1$TempC > 220 & data1$TempC < 240) # there is the first range where the maximum should occure (there are several maxima in the data1 set but i need that maximum close to 230 degree celsius

min <- subset(data1,data1$TempC > 390 & data1$TempC < 410) # same for the maximum i search for the minimum at a distinct place around 400 degree celsius

max_real <- max(max$value1) # select the real max

min_real <- min(min$value1) # select the real min

difference <- max_real -min_real # final difference value

#
# lapply for multiple files & store summaries by file

theFiles <- list.files("./data","\\.cur")
resultsList <- lapply(theFiles,function(x){
     data1<- read.fwf(paste0("./data/",x), widths = c(1, 5, 4, 5,4,6,1,5,13,3,34), 
                      skip = 1,stringsAsFactors = FALSE) 
     data1<- data1[,c(2,4,6,8,9)] 
     colnames(data1) <- c("TempC", "value1", "value2", "value3", "value4") 
     max<- subset(data1,data1$TempC > 220 & data1$TempC < 240) 
     min <- subset(data1,data1$TempC > 390 & data1$TempC < 410) 
     max_real <- max(max$value1) # select the real max
     min_real <- min(min$value1) # select the real min
     difference <- max_real -min_real # final difference value
     data.frame(fileName = x,min_real,max_real,difference)
})

# combine results into single data frame & print
do.call(rbind,resultsList)



