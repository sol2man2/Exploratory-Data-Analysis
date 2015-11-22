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
# 4

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
