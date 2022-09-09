library(ggplot2)

years <- read.csv("resources/years-reign.csv")
ggplot( years, aes(x=Reigning))+geom_bar()
ggsave( "years-reigning.png")
years$Century <- as.factor(years$Century)
ggplot( years, aes(x=Reigning,fill=Century,group=Century))+geom_bar(position='dodge')
