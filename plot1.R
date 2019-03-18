#Read the 2 RDS files
data<-readRDS("summarySCC_PM25.rds")
soc<- readRDS("Source_Classification_Code.rds")

#plot a bar diagram
barplot( tapply(data$Emissions, data$year, sum ), xlab="Year" , ylab="Emissions in Tons"
         , main="Sum of Emissions ")
dev.copy(png, "plot1.png")
dev.off()