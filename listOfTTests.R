#
# https://stackoverflow.com/questions/53455436/r-error-t-test-for-loop-command-between-variables
#

varList <- c("wt","disp","mpg")
results <- lapply(varList,function(x){
  t.test(mtcars[[x]] ~ mtcars$am)
})
names(results) <- varList
results