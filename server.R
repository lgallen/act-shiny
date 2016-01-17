
library(shiny)
library(plotly)
library(dplyr)

# Dataframe used for reactive radio selection later
labelSAT <- data.frame(c('percent_tested','combined','math','writing','critical_reading'),c("% Tested","Comb","Math","Write","Read"),stringsAsFactors = FALSE)
colnames(labelSAT) <- c('lab','name')
labelACT <- data.frame(c('percent_tested','composite','math','english','reading','science'),c("% Tested",'Comp.',"Math","English","Reading","Science"),stringsAsFactors = FALSE)
colnames(labelACT) <- c('lab','name')

# Parameters for Plotly
# give state boundaries a white border
l <- list(color = toRGB("white"), width = 2)
# specify some map projection/options
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)



shinyServer(function(input, output) {
  
  labName <- reactive ({
    if (input$panelID=="ACT") {
      t <- labelACT %>% filter(lab == radioChoice())
      return(t$name[1])      
    } else {
      t <- labelSAT %>% filter(lab == radioChoice())
      return(t$name[1])
    }
    
  })

# Returns year user selects  
  year <- reactive( {
    if (input$panelID=="ACT") {
      return(as.character(input$yearACT))} else {
        return(as.character(input$yearSAT))
      }
    })

# Reactive for radio choice returns percent_tested, math, etc.
  radioChoice <- reactive ({
    if (input$panelID=="ACT") {
      return(as.character(input$radioACT))} else {
        return(as.character(input$radioSAT))
      }
  })
  
  
# Create a reactive dataframe based on user selections of test, year, and radio attribute.  
  dftest <- reactive({
    filepath <- paste(c('data/',tolower(input$panelID),"_",year(),".csv"),collapse = "")
    filter_data <- read.csv(filepath)
    if (input$panelID=="ACT") {
      filter_data$hover <- with(filter_data, paste("Percent Tested", percent_tested, "<br>","Composite", composite, "<br>","English", english, "<br>",
                                                            "Math", math, "<br>","Reading", reading,
                                                            "<br>", "Science", science))} else {
    filter_data$hover <- with(filter_data, paste("Percent Tested", percent_tested, "<br>","Combined", combined, "<br>","Math", math, "<br>",
                                                 "Writing", writing, "<br>","Critical Reading", critical_reading
                                                ))
                                                            }
    return(filter_data)
    
  })
    
  
# Create US choropleth    
  output$trendPlot <- renderPlotly({
    radioC <- radioChoice()
    plot_ly(dftest(), z = eval(parse(text = radioC)), text = hover, locations = code, type = 'choropleth',
            locationmode = 'USA-states', color = eval(parse(text = radioC)), colors = 'Purples',
            marker = list(line = l), hoverinfo='location+text', colorbar = list(title = labName())) %>%
      layout(    
        
                 margin = list(
                   l = 0,
                   r = 0,
                   b = 0,
                   t = 0,
                   pad = 0
                 ), 
                 title = paste(c("","<br>",year(), input$panelID, "Scores","<br>","(hover or zoom for more detail)"), collapse = " "), 
             geo = g)
  })
  

# Outputs that follow for testing purposes only.    
#  output$testing <- renderText({year()
#  })

#  output$columns <- renderText({
#    colnames(dftest())
#  })
  
#  output$newdf <- renderDataTable({
#    df3 <- dftest()
#    df3
#  })

})