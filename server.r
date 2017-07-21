shinyServer(function(input, output, session ) {
  # Reactive Object
  bom_dat <- reactive({
    bom_data[!(bom_data$Parent %in% setdiff(as.character(master_products), as.character(input$product)) ), ]
  })

  bom_dat2 <- reactive({
    bom_data_2[!(bom_data$Parent %in% setdiff(as.character(master_products), as.character(input$product)) ), ]
  })

  # Data
  output$d1 <- renderDataTable({
    bom_data
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

  # Sankey diagrams
  output$sankey1 <- renderSankeyNetwork({
    x <- nodeLinkMaker( bom_data = bom_dat())
    sankeyPlotter(product_node = x$prod_node, links = x$prod_link)
  })

  # Simple Digraph
  output$simp_viz1 <- renderPlot({
    plot.igraph(graph_from_data_frame(d=bom_dat2(), directed=T))
  })


  output$bom_charts <-  renderUI({
    if(input$viz_type == "D3 Tree Visualization") return(collapsibleTreeOutput("tree1") )
    if(input$viz_type == "D3 Sankey Visualization") return(sankeyNetworkOutput("sankey1") )
    if(input$viz_type == "Simple Directed Graph") return(plotOutput("simp_viz1"))
  })

})
