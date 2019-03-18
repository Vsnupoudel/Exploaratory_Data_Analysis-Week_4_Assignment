library(ggplot2)
data<-readRDS("summarySCC_PM25.rds")
soc<- readRDS("Source_Classification_Code.rds")
#subset data for California,
#data from plot5.R is also used below but have not included that part here
cal<- data[ fips=="06037",]

#subset Vehichle data for California
calveh<- merge( Veh_SCC, cal, by.x="SCC", by.y="SCC")

#Plot the sums by year for both baltimore and california
bg<- tapply(baltveh$Emissions, baltveh$year, sum )
balg<- data.frame( year= names(bg) , state="Baltimore"  ,freq= bg  )

bg<- tapply(calveh$Emissions, calveh$year, sum )
calg<- data.frame( year= names(bg) , state="California"  ,freq= bg  )
#Rowbind these two and plot using two facets
vehunion<- rbind( balg, calg)
with(vehunion , qplot( year, freq, facets=.~state , lwd=5 , ylab="Total Emissions in Tonnes") )
dev.copy(png, "plot6.png")
dev.off()
