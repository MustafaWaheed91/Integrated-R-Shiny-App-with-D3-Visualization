shinyServer(
  function(input, output, session) {



  	# exception handler for when action button is clicked
  	observe({
  		if (input$var_run == 0){
  			return()
  		}
  		var_json = list(name="Product BOM",children=jsonlist(df))
  		session$sendCustomMessage(type="jsondata",var_json)
  	})

  }
)



