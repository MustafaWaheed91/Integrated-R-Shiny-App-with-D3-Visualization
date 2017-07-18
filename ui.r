shinyUI(
  navbarPage("Visualizing Nested Data with D3",
             tabPanel(title = "Finished Goods and Components"
                      ,fluidPage(tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "../css/custom.css")),theme = shinytheme("flatly"),sidebarLayout(
                        sidebarPanel(
                          tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css"))
                          , fluidRow(h3("This Appliction aims to")
                                     , p("investigate the relationship between finished goods and their component products.")
                                     , p("We will test the visualization by flipping between a few different chart types.")
                                     , p("The data tab on the main panel shows the data input used in this application."))
                          , hr()
                          , selectInput(inputId = "product", label = "Choose Product", choices = master_products, selected = master_products, multiple = T)
                          , br()
                          , radioButtons(inputId = "viz_type", label = "Choose Chart Type" , choices = c("D3 Tree Visualization", "D3 Sankey Visualization", "Simple Directed Graph"), selected = "D3 Tree Visualization" )
                          , actionButton("var_run", label="Update Chart")
                        ),
                        mainPanel( tabsetPanel(tabPanel("Nested Product View"
                                                        , uiOutput("bom_charts", height = 1200, width = 800)
                        )
                        ,tabPanel("Data"
                                  , h4(strong("Input Data"), align="center")
                                  , dataTableOutput('d1')
                        )

                        ))
                      ))
             )
             , collapsible = TRUE
  )
)