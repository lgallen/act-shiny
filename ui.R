library(shiny)
library(plotly)

shinyUI(pageWithSidebar(
  headerPanel("Select Test"),
  sidebarPanel(
    tabsetPanel(
      tabPanel("ACT Data", value="ACT",
               sliderInput('yearACT', label='Year of Exam', min=2004, max=2015, value=2014,sep="", step = 1, ticks=TRUE, round = TRUE),
               radioButtons("radioACT", label = h4("Color Map By"),
                            choices = list("Percent Tested" = "percent_tested", 
                                           "Composite" = "composite",
                                           "Math" = "math", 
                                           "English"= "english",
                                           "Reading"="reading",
                                           "Science"="science"),selected = "percent_tested")
               
               ), 
      tabPanel("SAT Data", value="SAT",
               sliderInput('yearSAT', label='Year of Exam', min=2011, max=2014, value=2014, sep="", step = 1, ticks=TRUE, round = TRUE),
               radioButtons("radioSAT", label = h3("Color Map By"),
                            choices = list("Percent Tested" = "percent_tested", 
                                           "Combined" = "combined",
                                           "Math" = "math", 
                                           "Writing"= "writing",
                                           "Critical Reading"="critical_reading"),selected = "percent_tested")
               
      )
      , id = "panelID"
    )
  ),
  mainPanel(
#    textOutput("testing"),
#    textOutput("columns"),
    plotlyOutput("trendPlot")
#    dataTableOutput("newdf")
 

  )
))