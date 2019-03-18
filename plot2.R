#Read the 2 RDS files
data<-readRDS("summarySCC_PM25.rds")
soc<- readRDS("Source_Classification_Code.rds")
#subset data for baltimore
balt<- data[ data$fips=="24510",]

#plot a bar diagram
bg<- tapply(balt$Emissions, balt$year, sum )
cg<- data.frame( year= names(bg) , freq= bg  )
xx<- barplot( cg$freq  , xlab="Year" , ylab="Emissions in Tons")
text(x = xx, y = cg$freq, label = as.integer( cg$freq ) , pos = 1, cex = 0.8, col = "red")
dev.copy(png, "plot2.png")
dev.off()