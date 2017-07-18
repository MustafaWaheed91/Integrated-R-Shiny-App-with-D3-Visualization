# This is a boiler plate script to chcek for packages and install and load them if they are no already
requiredPackages = c(
                     'shinythemes'
                     ,'shinyBS'
                     ,'threejs'
                     # ,'flexdashboard'
                     ,'d3Network'
                     ,'igraph'
                     ,'networkD3'
                     ,'visNetwork'
                     ,'data.table'
                     ,'DT'
                     ,'shinyAce'
                     ,'collapsibleTree'
                     ,'shinyjs'
                     ,'colourpicker'
                     ,'shinydashboard'
                     )

for(p in requiredPackages){
  if(!require(p,character.only = TRUE)) install.packages(p)
  library(p,character.only = TRUE)
}
