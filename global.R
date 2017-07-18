rm(list = ls())
source(file="loadPackages.R")
source(file="helper.R")


# Read in the input CSV's Here
bom_data <- read.csv("Bill of Materials Data.csv", stringsAsFactors = F)
prod_loc_master <- read.csv("Product Location Master.csv", stringsAsFactors = F)

colnames(bom_data)[3] <- "Qty Per"
master_parent <- unique(bom_data$Parent)
master_child <- unique(bom_data$Child)
master_products <- setdiff(master_parent, master_child)


Parent <- replicate(n = length(master_products), expr = "Products")

top_layer <- cbind(Parent, master_products)
colnames(top_layer)[2] <- "Child"

bom_data_2 <- rbind(bom_data[, c(1,2)],top_layer)

prod_loc_master_2 <- prod_loc_master[prod_loc_master$source != "", c("location", "source")]

prod_loc_master_3 <- unique(prod_loc_master_2)

master_loc <- unique(prod_loc_master_3$location)
master_source <- unique(prod_loc_master_3$source)
master_locations <- setdiff(master_loc, master_source)

names(prod_loc_master_3) <- c("Parent", "Child")

top_lev_loc <- cbind(replicate(n = length(master_locations), expr = "Locations"), master_locations)

colnames(top_lev_loc) <- c("Parent", "Child")

prod_loc_master_4 <- rbind(prod_loc_master_3, top_lev_loc)