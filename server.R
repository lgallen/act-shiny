
act.data2<-read.csv("data/act_2013.csv")
sat.data<-read.csv("data/sat_2013.csv")

library(googleVis)

func<- function (x) {
        test.type<-list(c("percent_tested","percent_tested"),c("composite","combined"),c("math","math"),c("english","writing"),c("reading","critical_reading"))
        test.type[[as.numeric(x)]]
}


shinyServer(
        function(input, output) {
                output$act<-renderGvis({gvisGeoChart(act.data2,locationvar="state",colorvar=input$radio, options=list(region="US", displayMode="regions", resolution="provinces", colorAxis="{colors:['#E6E6F0', '#00005C']}"))})
                output$sat<-renderGvis({gvisGeoChart(sat.data,locationvar="state",colorvar=input$radionew, options=list(region="US", displayMode="regions", resolution="provinces", colorAxis="{colors:['#FAE6E6', '#8F0000']}"))})
                output$compareact<-renderGvis({gvisGeoChart(act.data2,locationvar="state",colorvar= as.character(func(input$radionewest)[1]), options=list(region="US", displayMode="regions", resolution="provinces", colorAxis="{colors:['#E6E6F0', '#00005C']}"))})
                output$comparesat<-renderGvis({gvisGeoChart(sat.data,locationvar="state",colorvar= as.character(func(input$radionewest)[2]), options=list(region="US", displayMode="regions", resolution="provinces", colorAxis="{colors:['#FAE6E6', '#8F0000']}"))})
                
        })
