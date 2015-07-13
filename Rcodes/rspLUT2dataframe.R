##
## convert ncdf file to data.frame
##------------------------------------------
## this is in RSP format (e.g. I/Q
## vectors are of dim #cases x # lambda x # vza)

rspLUT2dataframe <- function(ncin) 
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
  clength<-length(filevarnames)+2
  
      for (count in 1:clength) 
      #for (count in 1) 
      {
        
        
        if        (count<=length(filevarnames))  {
          
          ## print some variable values
          
          varname<-filevarnames[count]
          varval <- get.var.ncdf(ncin, filevarnames[count])
          nvar   <- dim(varval)
          print(paste("variable ", filevarnames[count], "dim:"))
          print(nvar)
          print(paste("variable ", filevarnames[count], "sample data:"))
          print(head(varval))
          
          ## add data to initial data frame
          
          v       <- ncin$var[[count]]
          tmpvar  <- get.var.ncdf( ncin, v )
          l       <- length(dim(tmpvar))
          
          if        (l==1)  {
            print( "processing single col array")
            
            tmpdata <- as.data.frame(setNames(replicate(1,tmpvar, 
                                                        simplify = F), v$name))
            
            datframe<-cbind(datframe,tmpdata)
            
          } else {
            
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
          
          
        }  else {
          
          ## add computed variables into data frame
          
          print("processing computed variables")
          
                if        (count==length(filevarnames)+1)  {
                  #  Rp is polarized reflectance (sqrt(ref_q^2 + ref_u^2)) 
                  v1      <- ncin$var[[8]]
                  tmpvar1 <- get.var.ncdf( ncin, v1 )
                  Rp      <- sqrt(tmpvar1^2)
                  print(paste("variable ", "Rp ", "dim:"))
                  print(dim(Rp))
                  print(paste("variable ", "Rp ", "sample data:"))
                  print(head(Rp))
                  
                } else if   (count==length(filevarnames)+2)  {
                  
                  #  DoLP is degree of linear polarization (sqrt(ref_q^2 + ref_u^2)/ref_i)  
                  v2      <- ncin$var[[7]]
                  tmpvar2 <- get.var.ncdf( ncin, v2 )
                  DoLP    <- (sqrt(tmpvar1^2))/tmpvar2
                  print(paste("variable ", "DoLP ", "dim:"))
                  print(dim(DoLP))
                  print(paste("variable ", "DoLP ", "sample data:"))
                  print(head(DoLP))
                  
                }
          
                for (i in 1:dim2)
                {
                  for (j in 1:dim3)
                  {
                    
                        if        (count==length(filevarnames)+1)  {
                        
                        vname   <-paste("Rp","_lambda",as.character(i),"_",
                                        "vza_",as.character(j),sep ="")
                        tmpdata <- as.data.frame(setNames(replicate(1,Rp[,i,j], 
                                                                    simplify = F), vname))
                        
                        datframe<-cbind(datframe,tmpdata)
                        
                      } else if   (count==length(filevarnames)+2)  {
                        
                        vname   <-paste("DoLP","_lambda",as.character(i),"_",
                                        "vza_",as.character(j),sep ="")
                        tmpdata <- as.data.frame(setNames(replicate(1,DoLP[,i,j], 
                                                                    simplify = F), vname))
                        
                        datframe<-cbind(datframe,tmpdata)
                  
                      }
          
                  }
        
                }
  
            }
        
      } ## end of main for loop

        ## function output
           datframe

} ## end of function
  #-----------------
