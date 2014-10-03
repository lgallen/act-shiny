


shinyUI(navbarPage("Navbar",
                   tabPanel("ACT Data",
               
        fluidPage(
        titlePanel("Testing Data"),
        sidebarLayout(
                sidebarPanel(
                        radioButtons("radio", label = h3("ACT Data 2013"),
                                     choices = list("Percent Tested" = "percent_tested", 
                                                    "Composite" = "composite",
                                                    "Math" = "math", 
                                                    "English"= "english",
                                                    "Reading"="reading",
                                                    "Science"="science"),selected = "percent_tested")
              
                        ),
                mainPanel(
                        htmlOutput("act")
                        
                )
        )
)),

tabPanel("SAT Data",
         fluidPage(
                 titlePanel("Testing Data"),
                 sidebarLayout(
                         sidebarPanel(
                                 radioButtons("radionew", label = h3("SAT Data 2013"),
                                              choices = list("Percent Tested" = "percent_tested", 
                                                             "Combined" = "combined",
                                                             "Math" = "math", 
                                                             "Writing"= "writing",
                                                             "Critical Reading"="critical_reading"),selected = "percent_tested")
                                 
                         ),
                         mainPanel(
                                 htmlOutput("sat")
                                 
                         )
                 )
         )),

tabPanel("Compare",
         fluidPage(
                 titlePanel("Testing Data"),
                 sidebarLayout(
                         sidebarPanel(
                                 radioButtons("radionewest", label = h3("ACT vs. SAT Data"),
                                              choices = list("Percent Tested" = 1, 
                                                             "Composite vs. Combined" = 2,
                                                             "Math vs. Math" = 3, 
                                                             "English vs. Writing"= 4,
                                                             "Reading vs. Critical Reading"=5),selected = 1)
                                 
                         ),
                         mainPanel(
                                 
                                 htmlOutput("compareact"),
                                 htmlOutput("comparesat")
                                 
                                 
                         )
                 )
         ))


))
