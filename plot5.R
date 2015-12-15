library(plyr)
library(ggplot2)
NEI <- readRDS("C:/Users/tesfamic/Desktop/Data/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/tesfamic/Desktop/Data/Source_Classification_Code.rds")
BaltimoreCityMV <- subset(NEI, fips == "24510" & type=="ON-ROAD")
BaltimoreMVPM25ByYear <- ddply(BaltimoreCityMV, .(year), function(x) sum(x$Emissions))
BaltimoreMVPM25ByYear <- ddply(BaltimoreCityMV, .(year), function(x) sum(x$Emissions))
colnames(BaltimoreMVPM25ByYear)[2] <- "Emissions"
png("plot5.png")
qplot(year, Emissions, data=BaltimoreMVPM25ByYear, geom="line") +
ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
xlab("Year") +
ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()

