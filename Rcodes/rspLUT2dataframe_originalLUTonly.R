##
## convert ncdf file to data.frame
##------------------------------------------
## this is in RSP format (e.g. I/Q
## vectors are of #cases x # lambda x # vza)

rspLUT2dataframe_originalLUTonly <- function(ncin) 
{
  ## get a sample of all vars in the nc file
  ## and save variables into data.frame
  
  filevarnames<-names(ncin$var)
  
  ## create initial data frame
  
  vname     <- "case"
  tmpvar    <- get.var.ncdf( ncin, "cod" )
  tmpcas    <- as.factor(c(1:length(tmpvar)))
  datframe  <- as.data.frame(setNames(replicate(1,tmpcas, 
                                                simplify = F), vname))
  
  #v         <- ncin$var[[1]]
  #tmpvar    <- get.var.ncdf( ncin, v )
  #datframe  <- as.data.frame(setNames(replicate(1,tmpvar, 
  #                                              simplify = F), v$name))
  
  
      for (count in 1:length(filevarnames)) 
      {
        
        varname<-filevarnames[count]
        varval <- get.var.ncdf(ncin, filevarnames[count])
        nvar   <- dim(varval)
        print(paste("variable ", filevarnames[count], "dim:"))
        print(nvar)
        print(paste("variable ", filevarnames[count], "sample data:"))
        print(head(varval))
        
        ## add data to initial data frame
        if        (count<=length(filevarnames))  {
          v       <- ncin$var[[count]]
          tmpvar  <- get.var.ncdf( ncin, v )
          l       <- length(dim(tmpvar))
          
          if        (l==1)  {
            print( "processing single col array")
            
            tmpdata <- as.data.frame(setNames(replicate(1,tmpvar, 
                                                        simplify = F), v$name))
            
            datframe<-cbind(datframe,tmpdata)
            
          } else{
            print("processing multiple col arrays")
            dim1<-  dim(tmpvar)[1]
            dim2<-  dim(tmpvar)[2]
            dim3<-  dim(tmpvar)[3]
            
            for (i in 1:dim2)
            {
              for (j in 1:dim3)
              {
                vname   <-paste(v$name,"_lambda",as.character(i),"_",
                                "vza_",as.character(j),sep ="")
                tmpdata <- as.data.frame(setNames(replicate(1,tmpvar[,i,j], 
                                                            simplify = F), vname))
                
                datframe<-cbind(datframe,tmpdata)
                
              }
              
            }
          }
          
          
        }  
        
      }
  
  ## function output
  datframe
}