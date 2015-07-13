##
## run pca analysis on a given dataset
##------------------------------------
   runpcaana <- function(filename) 
  {
     
      ## filename is file to be analyzed, e.g. "~/R/oracles_polar_algorithm/data/NN_clouds_20150701.nc"
      ## it can be .nc, .csv, or any other R data frame object
     
      ## check file extension
     
      filetype <- file_ext(filename)
      
      if        (  filetype=="nc")  {
            print( "reading .nc file")
            
            ## readncdf
            
            ncin    <-readncdf(filename)
            
            ## get a sample of all vars in the nc file
            ## and save variables into data.frame
            
            datframe<-rspLUT2dataframe(ncin)
            
            close.ncdf(ncin)
           
        
      } else if ( filetype=="csv") {
            print("reading .csv file")
        
      } else if ( filetype=="rda") {
            print("reading .rda file")
        
      } else
            print("save data as either .nc/.csv/.rda")
      
      ## function output
      datframe
     
   }