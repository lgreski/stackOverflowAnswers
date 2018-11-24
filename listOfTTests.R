#
# https://stackoverflow.com/questions/53455436/r-error-t-test-for-loop-command-between-variables
#
data(mtcars)
varList <- c("wt","disp","mpg")
results <- lapply(varList,function(x){
  t.test(mtcars[[x]] ~ mtcars$am)
})
names(results) <- varList

# print results

for(i in 1:length(results)){
  message(paste("for variable:",names(results[i]),"difference between manual and automatic transmissions is:"))
  print(results[[i]])
}