rm(list = ls())
source(file="loadPackages.R")
source(file="helper.R")

bom_data <- read.csv("Bill of Materials Data.csv", stringsAsFactors = F)

colnames(bom_data)[3] <- "Qty Per"
master_parent <- unique(bom_data$Parent)
master_child <- unique(bom_data$Child)
master_products <- setdiff(master_parent, master_child)

Parent <- replicate(n = length(master_products), expr = "Products")
top_layer <- cbind(Parent, master_products)
colnames(top_layer)[2] <- "Child"

bom_data_2 <- rbind(bom_data[, c(1,2)],top_layer)