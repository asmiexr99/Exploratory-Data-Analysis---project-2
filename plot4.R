library(plyr)
library(ggplot2)
NEI <- readRDS("C:/Users/tesfamic/Desktop/Data/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/tesfamic/Desktop/Data/Source_Classification_Code.rds")
CoalCombustionSCC <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Institutional - Coal",
"Fuel Comb - Electric Generation - Coal",
"Fuel Comb - Industrial Boilers, ICEs - Coal"))
CoalCombustionSCC1 <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))
nrow(CoalCombustionSCC)
nrow(CoalCombustionSCC1)
d1 <- setdiff(CoalCombustionSCC, CoalCombustionSCC1)
d2 <- setdiff(CoalCombustionSCC1, CoalCombustionSCC)
length(d1)
length(d2)
d3 <- setdiff(CoalCombustionSCC$SCC, CoalCombustionSCC1$SCC)
d4 <- setdiff(CoalCombustionSCC1$SCC, CoalCombustionSCC$SCC)
length(d3)
length(d4)
CoalCombustionSCCCodes <- union(CoalCombustionSCC$SCC, CoalCombustionSCC1$SCC)
length(CoalCombustionSCCCodes)
CoalCombustion <- subset(NEI, SCC %in% CoalCombustionSCCCodes)
coalCombustionPM25ByYear <- ddply(CoalCombustion, .(year, type), function(x) sum(x$Emissions))
colnames(coalCombustionPM25ByYear)[3] <- "Emissions"
png("plot4.png")
qplot(year, Emissions, data=coalCombustionPM25ByYear, color=type, geom="line") +
stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum",
color = "black", aes(shape="total"), geom="line") +
geom_line(aes(size="total", shape = NA)) +
ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) +
xlab("Year") +
ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()

