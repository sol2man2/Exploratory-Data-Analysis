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

year_emissions <- sqldf("select SCC, year, sum(Emissions) as emissions from NEI group by year")
head(year_emissions)

g <- ggplot(year_emissions, aes(x=year, y=emissions)) + geom_line()
plot(g)
ggsave("year_emissions.png",g)

names(year_emissions)
plot(year_emissions$emissions, year_emissions$year, type="l", pch=2)
dev.off()

png("plot1.png")
plot(year_emissions$year, year_emissions$emissions, type="l", pch=2)
dev.off()

# #################################################################
# 2

head(NEI)
colnames(NEI)
colnames(SCC)

mayland_year_emissions <- sqldf("select type, year, sum(Emissions) as emissions from NEI where fips == '24510' group by year")
mayland_year_emissions

png("plot2.png")
plot(mayland_year_emissions$year, mayland_year_emissions$emissions, type="l", pch=2)
dev.off()

# #################################################################
# 3

head(NEI)
dim(NEI)
str(NEI)
colnames(NEI)
unique(NEI$type)

head(SCC)
dim(SCC)
colnames(SCC)
head(SCC,1)

mayland_year_emissions <- sqldf("select type, year, sum(Emissions) as emissions from NEI where fips == '24510' group by year, type")

mayland_year_emissions
g <- ggplot(mayland_year_emissions, aes(x=year, y=emissions, colour = type)) + geom_line()
plot(g)
ggsave("plot3.png",g)

# #################################################################
# 4

head(NEI)
dim(NEI)
str(NEI)
colnames(NEI)
unique(NEI$type)

head(SCC)
dim(SCC)
colnames(SCC)
head(SCC,1)
View(SCC)

year_scc_emissions <- sqldf("select year, SCC, sum(Emissions) as emissions from NEI group by year, SCC")

searched <- {}
for(idx in 1:ncol(SCC)) {
  searched1 <- grep("coal", SCC[,idx])
  if(length(searched1) != 0) {
    searched <- c(searched, as.numeric(as.character(SCC[searched1, "SCC"])))
  }
  searched2 <- grep("Coal", SCC[,idx])
  if(length(searched2) != 0) {
    searched <- c(searched, as.numeric(as.character(SCC[searched2, "SCC"])))
  }
}
searched <- unique(searched)

result_index <- {}
for(idx in year_scc_emissions$SCC) {
  result <- FALSE
  for(ii in searched) {
    if(ii == idx) result <- TRUE
  }
  result_index <- c(result_index, result)
}
sub_year_scc_emissions <- year_scc_emissions[result_index,]
dim(sub_year_scc_emissions)

g <- ggplot(sub_year_scc_emissions, aes(x=year, y=emissions, colour = SCC)) + geom_line()
plot(g)
ggsave("plot4.png",g)

# #################################################################
# 5

moter_year_scc_emissions <- sqldf("select year, SCC, sum(Emissions) as emissions from NEI where fips == '24510' group by year, SCC")

searched <- {}
for(idx in 1:ncol(SCC)) {
  searched1 <- grep("coal", SCC[,idx])
  if(length(searched1) != 0) {
    searched <- c(searched, as.numeric(as.character(SCC[searched1, "SCC"])))
  }
  if(length(searched2) != 0) {
    searched <- c(searched, as.numeric(as.character(SCC[searched2, "SCC"])))
  }
}
searched <- unique(searched)

result_index <- {}
for(idx in moter_year_scc_emissions$SCC) {
  result <- FALSE
  for(ii in searched) {
    if(ii == idx) result <- TRUE
  }
  print(idx)
  result_index <- c(result_index, result)
}
sub_moter_year_scc_emissions <- moter_year_scc_emissions[result_index,]
dim(sub_moter_year_scc_emissions)

g <- ggplot(sub_moter_year_scc_emissions, aes(x=year, y=emissions, colour = SCC)) + geom_line()
plot(g)
ggsave("plot5.png",g)

# #################################################################
# 6

moter_area_emissions <- sqldf("select fips, sum(Emissions) as emissions from NEI where fips == '24510' or fips == '06037' group by fips")

g <- ggplot(moter_area_emissions, aes(x=fips, y=emissions)) + geom_point(size=10)
plot(g)
ggsave("plot6.png",g)
