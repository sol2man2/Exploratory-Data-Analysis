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
# 3

mayland_year_emissions <- sqldf("select type, year, sum(Emissions) as emissions from NEI where fips == '24510' group by year, type")

mayland_year_emissions
g <- ggplot(mayland_year_emissions, aes(x=year, y=emissions, colour = type)) + geom_line()
plot(g)
ggsave("plot3.png",g)
