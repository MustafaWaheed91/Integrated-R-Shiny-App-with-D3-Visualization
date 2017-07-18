shinyUI(
  navbarPage("Bill Of Materials",
             tabPanel(title = "Vizulizations"
                      ,fluidPage(tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "../css/custom.css")),theme = shinytheme("flatly"),sidebarLayout(
                        sidebarPanel(
                          tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css"))
                          , fluidRow(h4("This Appliction aims to")
                                     , p("investigate a few visualization approaches for Bill of Material (B.O.M) data. This particular application has two view to show relevant details.")
                                     , strong("1. BOM View")
                                     , br()
                                     , strong("2. Location View")
                                     , br()
                                     , p("We will test the visualization by flipping between a few different chart types.")
                                     , br()
                                     , p("The data tab on the main panel shows the two data inputs used in this application."))
                          , hr()
                          , selectInput(inputId = "product", label = "Choose Product", choices = master_products, selected = master_products, multiple = T)
                          , br()
                          , radioButtons(inputId = "viz_type", label = "Choose Graph Type" , choices = c("D3 Tree Visualization", "D3 Sankey Visualization", "Simple Directed Graph", "threeJS", 'visNetwork'), selected = "D3 Tree Visualization" )
                          # , actionButton("var_run", label="Update Graph")
                        ),
                        mainPanel( tabsetPanel(tabPanel("BOM View"
                                                        , uiOutput("bom_charts", height = 1000, width = 1000)
                        )
                        ,tabPanel("Location View"
                                  , uiOutput("loc_charts", height = 1000, width = 1000)
                        )
                        ,tabPanel("Data"
                                  , h4(strong("Bill Of Materials Data"), align="center")
                                  , dataTableOutput('d1')
                                  , h4(strong("Product Location Master"), align="center")
                                  , dataTableOutput('d2')
                        )

                        ))
                      ))
             )
             , collapsible = TRUE
  )
)