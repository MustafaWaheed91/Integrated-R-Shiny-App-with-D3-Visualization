# Tthis file layes out some helper functions that will be used in the server.R script

nodeLinkMaker <- function(bom_data){
  bom_data_sank <- as.data.table(bom_data)

  all_prods <- as.data.frame(cbind(seq_along(unique(c(bom_data_sank$Parent, bom_data_sank$Child))), unique(c(bom_data_sank$Parent, bom_data_sank$Child))))
  colnames(all_prods) <- c("product_id","product")
  all_prods$product_id <- as.integer(all_prods$product_id)

  bom_data_sank_2 <- merge(x = bom_data_sank, y = all_prods, by.x = "Parent", by.y = "product")
  bom_data_sank_2 <- merge(bom_data_sank_2,all_prods, by.x = "Child", by.y = "product")

  bom_data_sank_2$`Parent Name`<- bom_data_sank_2$Parent
  bom_data_sank_2$Parent <- bom_data_sank_2$product_id.x


  bom_data_sank_2$`Child Name` <- bom_data_sank_2$Child
  bom_data_sank_2$Child <- bom_data_sank_2$product_id.y


  bom_data_sank_2$product_id.x <- NULL
  bom_data_sank_2$product_id.y <- NULL


  # Links data frame
  bom_data_sank <- bom_data_sank_2[, list(`Quantity Per` = sum(`Qty Per`)), by = c("Parent","Child") ]
  links <- as.data.frame(bom_data_sank)
  links[] <- lapply(links, function(x) as.numeric(as.character(x)))
  links[, 1:2] <- links[, 1:2] - 1

  # Nodes data frame
  product_node = data.frame(name = paste0("Product No. ",all_prods$product ))

  return(list(prod_node = product_node, prod_link = links))
}


sankeyPlotter <- function(links, product_node){

  sankeyNetwork(Links = links,
                Nodes = product_node,
                Source = "Child",
                Target = "Parent",
                Value = "Quantity Per",
                NodeID = "name",
                units = "Lbs",
                fontSize = 18,
                nodeWidth = 30)



}
