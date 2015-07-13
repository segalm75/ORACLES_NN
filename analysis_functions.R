## this file uploads all
## needed libraries
## needed function
## datasets used in analysis
## for Oracles Polarimetry Algorithm Project
##------------------------------------------

## Michal Segal Rozenhaimer, 2015-06-30
##------------------------------------------

## libraries
library(kohonen)
library(devtools)
library(RCurl)
library(ggplot2)
library(stats)
library(grid)
library(nnet)
library(RSNNS)
library(NeuralNetTools)
library(ncdf)
library(chron)
library(RColorBrewer)
library(lattice)
library(tools)
library(reshape)
library(ggbiplot)
library(ggfortify)
library(data.table)


require(graphics)
require(ggplot2)
require(reshape)

## R functions
#-------------

## main scheme flows
source("~/R/oracles_polar_algorithm//Rcodes/runpcaana.R")

## general/plotting
source("~/R/oracles_polar_algorithm//Rcodes/multiplot.R")
source('~/R/oracles_polar_algorithm/Rcodes/myImagePlot.R')

## utils
source("~/R/oracles_polar_algorithm//Rcodes/readncdf.R")
source("~/R/oracles_polar_algorithm/Rcodes/rspLUT2dataframe.R")

## data sets
#  nir  <-load("~/R/win-library/3.1/kohonen/data/nir.rda")
#  wines<-load("~/R/win-library/3.1/kohonen/data/wines.rda")
#  yeast<-load("~/R/win-library/3.1/kohonen/data/yeast.rda")
