
hpc <- read.table("household_power_consumption.txt", sep=";", header=T)

dim(hpc)
colnames(hpc)
head(hpc,1)

head(hpc[,1])
class(hpc[,1])

filtered.index <- which(hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007")
filtered.hpc <- hpc[filtered.index,]
# dim(filtered.hpc)
