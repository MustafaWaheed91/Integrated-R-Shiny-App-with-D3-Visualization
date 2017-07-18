# This file contains some helper functions to assist with the Visualization Application.
# The following Script checks if packages are installed and if not it installs them from CRAN and loads them.
source("loadPackages.R")

# JSON: dataframe input to json using toJSON (in list form)
jsonlist <- function(x){
  templist <- split(x[-1],x[1],drop=TRUE)
  lapply(names(templist),function(y){
    if (templist[[y]][1,1]=="end"){
      list(name=y)
    } else {
      list(name=y,children=jsonlist(templist[[y]]))
    }
  })
}

# Load the Data Here:

df <- read.csv("Product Component Information.csv")

# df=data.frame(
#   col1=c("Product 1","Product 1","Product 2","Product 2","Product 2","Product 2","Product 2"),
#   col2=c("Sub Product A","Sub Product B","Sub Product A","Sub Product B","Sub Product A","Sub Product C","Sub Product C"),
#   col3=c("end","end","end","end","TRUE","Sub Product A","Sub Product A"),
#   col4=c("","","","","end","Raw Material A","Raw Material B"),
#   col5=c("","","","","","end","end")
# )