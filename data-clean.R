# Data sources
# ACT data http://www.act.org/newsroom/data/2013/states.html
# SAT data http://www.commonwealthfoundation.org/policyblog/detail/sat-scores-by-state-2013

# Read in ACT Data
act.data<-read.csv("act_data.csv")
act.data2<-act.data
act.data2$state<-as.character(act.data2$state)

# googleVis not recognizing two word state names initially, so redefine them here
act.data2$state[9]<-"District of Columbia"
act.data2$state[30]<-"New Hampshire"
act.data2$state[31]<-"New Jersey"
act.data2$state[32]<-"New Mexico"
act.data2$state[33]<-"New York"
act.data2$state[34]<-"North Carolina"
act.data2$state[35]<-"North Dakota"
act.data2$state[41]<-"South Carolina"
act.data2$state[42]<-"South Dakota"
act.data2$state[49]<-"West Virginia"
act.data2<-act.data2[1:51,]

# File must be saved in UTF-8 for Shiny purposes
write.csv(act.data2,file="act_2013.csv",fileEncoding="UTF-8")

# Read in SAT Data
sat.data<-read.csv("sat_data.csv")
# Give column names that correspond to ACT Data
colnames(sat.data)<-c("rank","state","percent_tested","critical_reading","math","writing","combined")
# Remove % symbol and convert to integers
sat.data$percent_tested<-gsub("%","",sat.data$percent_tested)
sat.data$percent_tested<-as.integer(sat.data$percent_tested)

write.csv(sat.data,file="sat_2013.csv",fileEncoding="UTF-8")


