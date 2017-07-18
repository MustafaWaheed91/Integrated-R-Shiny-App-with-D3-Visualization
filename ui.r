# # SHINY & D3JS SIMPLE BINDING
# shinyUI(fluidPage(
#   titlePanel(h3("Shiny & D3JS: Custom Message Handler", align = "center")),
#   sidebarLayout(
#     sidebarPanel(
#     	tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),
#     	# selectInput("select1","Choose Finished Good",choices = c("Product 1","Product 2","Product 3")),
#     	sliderInput("slider1", "Choose Tree Density", min = 1, max = 4, value = 3),
#     	actionButton("var_run",label="Generate Diagram")
#     	),
#     mainPanel(
#       # load D3JS library
#       tags$script(src="http://d3js.org/d3.v3.min.js"),
#       # load javascript
#       tags$script(src="tree.js"),
#       # create div
#       tags$div(id="div_tree")
#     )
#   )
# ))


shinyUI(navbarPage("Visualizing Nested Data",
              tabPanel("with R and D3"
                       ,fluidPage(
                         tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
                         ,tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "../css/custom.css")),theme = shinytheme("flatly"),sidebarLayout(
                         sidebarPanel(
                           h4("Click the button below to generate the Visualization")
                           ,br()
                           # ,strong("Please make sure ")
                           ,hr()
                           ,actionButton("var_run",label="Generate Diagram")
                         ),
                         mainPanel( tabsetPanel(tabPanel("Nested Tree",
                                                         # load D3JS library
                                                         tags$script(src="http://d3js.org/d3.v3.min.js"),
                                                         # load javascript
                                                         tags$script(src="tree.js"),
                                                         # create div
                                                         tags$div(id="div_tree")
                                                        )
                                                ,tabPanel("View Input Data",

                                                          )

                         ))
                       ))
              )

))