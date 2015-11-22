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
# 6

moter_area_emissions <- sqldf("select fips, sum(Emissions) as emissions from NEI where fips == '24510' or fips == '06037' group by fips")

g <- ggplot(moter_area_emissions, aes(x=fips, y=emissions)) + geom_point(size=10)
plot(g)
ggsave("plot6.png",g)
