##
## read ncdf file
##---------------

readncdf <- function(filename) 
{
  ncin <- open.ncdf(filename,readunlim=FALSE)
  print(ncin)
  filevarnames<-names(ncin$var)
  print(" file variable names:")
  print(filevarnames)
  ncin
  ## test
  #sizea <- get.var.ncdf(ncin, "sizea")
  #nsizea <- dim(sizea)
  #print(nsizea)
  #print(head(sizea))
}