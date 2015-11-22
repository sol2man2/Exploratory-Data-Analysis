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
# 2

head(NEI)
colnames(NEI)
colnames(SCC)

mayland_year_emissions <- sqldf("select year, sum(Emissions) as emissions from NEI where fips == '24510' group by year")
mayland_year_emissions

png("plot2.png")
plot(mayland_year_emissions$year, mayland_year_emissions$emissions, type="l", pch=2)
dev.off()
