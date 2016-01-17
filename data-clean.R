# Data sources
# ACT data http://www.act.org/newsroom/data/2014/states.html
# SAT data http://www.commonwealthfoundation.org/policyblog/detail/sat-scores-by-state-2014

setwd("C:/Users/lgall/Documents/GitHub/act-shiny2/data")

# Read in ACT Data
act.data<-read.csv("act_2015.csv")
act.data2<-act.data
colnames(act.data2)<-c("state","percent_tested","composite","english","math","reading","science")
act.data2$state<-as.character(act.data2$state)


# googleVis not recognizing two word state names initially, so redefine them here
act.data2$state[9]<-"District of Columbia"
act.data2$state[30]<-"New Hampshire"
act.data2$state[31]<-"New Jersey"
act.data2$state[32]<-"New Mexico"
act.data2$state[33]<-"New York"
act.data2$state[34]<-"North Carolina"
act.data2$state[35]<-"North Dakota"
act.data2$state[40]<-"Rhode Island"
act.data2$state[41]<-"South Carolina"
act.data2$state[42]<-"South Dakota"
act.data2$state[49]<-"West Virginia"
act.data2<-act.data2[1:51,]

dfMerge <- data.frame(state.name,state.abb)
colnames(dfMerge) <- c("state","code")
act.data2 <- merge(act.data2,dfMerge,by = "state",all = TRUE)
act.data2$code <- as.character(act.data2$code)
act.data2$code[9] <- "DC"

# File must be saved in UTF-8 for Shiny purposes
write.csv(act.data2,file="act_2015.csv",fileEncoding="UTF-8",row.names = FALSE)

# Read in SAT Data
sat.data<-read.csv("sat_2012.csv")
# Give column names that correspond to ACT Data
colnames(sat.data)<-c("rank","state","percent_tested","critical_reading","math","writing","combined")
# Remove % symbol and convert to integers
sat.data$percent_tested<-gsub("%","",sat.data$percent_tested)
sat.data$percent_tested<-as.integer(sat.data$percent_tested)

sat.data <- merge(sat.data,dfMerge,by = "state",all = TRUE)
sat.data$code <- as.character(sat.data$code)
sat.data$code[9] <- "DC"


write.csv(sat.data,file="sat_2012.csv",row.names = FALSE)
#fileEncoding="UTF-8",

