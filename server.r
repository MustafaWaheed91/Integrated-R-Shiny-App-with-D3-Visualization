shinyServer(function(input, output, session ) {

  bom_dat <- reactive({
    bom_data[!(bom_data$Parent %in% setdiff(as.character(master_products), as.character(input$product)) ), ]
  })



  # Data
  output$d1 <- renderDataTable({
    bom_data
  }, options=list(scrollX=TRUE))

  output$d2 <- renderDataTable({
    prod_loc_master
  }, options=list(scrollX=TRUE))


  # Tree diagrams
  output$tree1 <- renderCollapsibleTree({
    `Product BOM` <- bom_dat()
    collapsibleTree(`Product BOM`
                    ,hierarchy = c("Parent", "Child")
                    ,attribute = "Qty Per"
                    ,tooltip = T
    )
  })


  output$tree2 <- renderCollapsibleTree({
    collapsibleTree(prod_loc_master_3
                    ,hierarchy = c("Parent", "Child")
                    ,tooltip = T
    )
  })



  # Sankey diagrams
  output$sankey1 <- renderSankeyNetwork({
    x <- nodeLinkMaker( bom_data = bom_dat())
    sankeyPlotter(product_node = x$prod_node, links = x$prod_link)
  })

  output$sankey2 <- renderSankeyNetwork({

    prod_loc_master_3$`Qty Per` <- 1
    x <- nodeLinkMaker(prod_loc_master_3)
    sankeyPlotter(product_node = x$prod_node, links = x$prod_link)
  })


  # Simple Digraph
  output$simp_viz1 <- renderPlot({
    plot.igraph(graph_from_data_frame(d=bom_dat(), directed=T))
  })


  output$simp_viz2 <- renderPlot({
    prod_loc_master_3.5 <- prod_loc_master_2[, c(2,1)]
    plot.igraph(graph_from_data_frame(d=prod_loc_master_3.5, directed=T))
  })


  output$bom_charts <-  renderUI({

    if(input$viz_type == "D3 Tree Visualization") return(collapsibleTreeOutput("tree1") )
    if(input$viz_type == "D3 Sankey Visualization") return(sankeyNetworkOutput("sankey1") )
    if(input$viz_type == "Simple Directed Graph") return(plotOutput("simp_viz1"))

  })

  output$loc_charts <-  renderUI({

    if(input$viz_type == "D3 Tree Visualization") return(collapsibleTreeOutput("tree2") )
    if(input$viz_type == "D3 Sankey Visualization") return( sankeyNetworkOutput("sankey2") )
    if(input$viz_type == "Simple Directed Graph") return( plotOutput("simp_viz2") )
  })

})
