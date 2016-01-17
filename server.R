
library(shiny)
library(plotly)
library(dplyr)

labelSAT <- data.frame(c('percent_tested','combined','math','writing','critical_reading'),c("% Tested","Comb","Math","Write","Read"),stringsAsFactors = FALSE)
colnames(labelSAT) <- c('lab','name')
labelACT <- data.frame(c('percent_tested','composite','math','english','reading','science'),c("% Tested",'Comp.',"Math","English","Reading","Science"),stringsAsFactors = FALSE)
colnames(labelACT) <- c('lab','name')


df1 <- data.frame(state.name,state.abb)
colnames(df1) <- c("state","code")

df <- merge(df,df1, all.x=TRUE)
df$code <- as.character(df$code)
df$code[9] <- "DC"




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
  
  year <- reactive( {
    if (input$panelID=="ACT") {
      return(as.character(input$yearACT))} else {
        return(as.character(input$yearSAT))
      }
    })
  
  radioChoice <- reactive ({
    if (input$panelID=="ACT") {
      return(as.character(input$radioACT))} else {
        return(as.character(input$radioSAT))
      }
  })
  
  
  
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
    
  
    
  output$trendPlot <- renderPlotly({
    plot_ly(dftest(), z = eval(parse(text = radioChoice())), text = hover, locations = code, type = 'choropleth',
            locationmode = 'USA-states', color = eval(parse(text = radioChoice())), colors = 'Purples',
            marker = list(line = l), hoverinfo='location+text', colorbar = list(title = labName())) %>%
      layout(title = paste(c("","<br>",year(), input$panelID, "Scores","<br>","(hover or zoom for more detail)"), collapse = " "), 
             geo = g)
  })
  
  
  output$testing <- renderText({year()
  })

  output$columns <- renderText({
    colnames(dftest())
  })
  
  output$newdf <- renderDataTable({
    df3 <- dftest()
    df3
  })
})