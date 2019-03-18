library(ggplot2)
data<-readRDS("summarySCC_PM25.rds")
soc<- readRDS("Source_Classification_Code.rds")
#subset data for baltimore
balt<- data[ data$fips=="24510",]

#Analyse soc to find Vehicles sources
#Take out only the SCC that are related to any Vehicles and
#merge them with the balt (baltimore) dataset to for a new data set baltveh
Veh<- which( grepl("[Vv]eh", soc$Short.Name)  ) # That have Veh or veh in their Short Name
Veh_SCC<- as.data.frame ( SCC=soc[Veh,1]  )
baltveh<- merge( Veh_SCC, balt, by.x="SCC", by.y="SCC")

#Plot the sums by year
bg<- tapply(baltveh$Emissions, baltveh$year, sum )
cg<- data.frame( year= names(bg) , freq= bg  )
with(cg , qplot( year, freq ), lwd=5 )
dev.copy(png, "plot5.png")
dev.off()
