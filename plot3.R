library(tidyr)
library(lubridate)
library(ggplot2)
#Read the 2 RDS files
data<-readRDS("summarySCC_PM25.rds")
soc<- readRDS("Source_Classification_Code.rds")
#subset data for baltimore
balt<- data[ data$fips=="24510",]

#get the summary as a dataframe
baltsum<- data.frame( Emission_sum=tapply( balt$Emissions, interaction(balt$type, balt$year) , sum ) 
        , type.year=  names( tapply( balt$Emissions, interaction(balt$type, balt$year) , sum )  ) )
baltsum<-separate(data= baltsum, col="type.year",into= c("type", "year"), sep="\\.")
rownames(baltsum)<-NULL

#Now plot and export
g<- ggplot( baltsum,  aes( year , Emission_sum ) )
g+ geom_point()+facet_grid(.~type)+theme(axis.text=element_text(size=10) )
dev.copy(png, "plot3.png")
dev.off()