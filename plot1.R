library(swirl)
library(sqldf)
library(ggplot2)

NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

head(NEI)
dim(NEI)
str(NEI)
colnames(NEI)

head(SCC)
dim(SCC)
colnames(SCC)
head(SCC,1)

# #################################################################
# 1

year_emissions <- sqldf("select year, sum(Emissions) as emissions from NEI group by year")
head(year_emissions)

g <- ggplot(year_emissions, aes(x=year, y=emissions)) + geom_line()
plot(g)
ggsave("year_emissions.png",g)

names(year_emissions)
plot(year_emissions$emissions, year_emissions$year, type="l", pch=2)
dev.off()

png("plot1.png")
plot(year_emissions$emissions, year_emissions$year, type="l", pch=2)
dev.off()
