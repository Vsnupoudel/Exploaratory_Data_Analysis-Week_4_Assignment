library(ggplot2)
data<-readRDS("summarySCC_PM25.rds")
soc<- readRDS("Source_Classification_Code.rds")

#Analyse soc to find Coal Combustion related sources
cc<- which( grepl("[Cc][Oo][Aa][Ll]", soc$Short.Name)  ) 
coal_SCC <- data.frame(SCC= soc[cc,]$SCC)
data_coal<- merge( coal_SCC, data, by.x="SCC", by.y="SCC")

#plot the total emissions from data_coal 
bg<- tapply(data_coal$Emissions, data_coal$year, sum )
cg<- data.frame( year= names(bg) , freq= bg  )
with(cg , qplot( year, freq , lwd=5 , ylab="Emissions in Tonnes")  )

dev.copy(png, "plot4.png")
dev.off()

