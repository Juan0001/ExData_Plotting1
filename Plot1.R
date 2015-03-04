## Read the data and subset data from the dates 2007-02-01 and 2007-02-02
data <- read.table("./Data/household_power_consumption.txt", 
                   header = TRUE, 
                   sep = ";", 
                   stringsAsFactors = FALSE)
library(dplyr)
wData <- filter(elecData, Date == "1/2/2007" | Date == "2/2/2007")

## Convert the Date and Time variables to Date/Time classes
wData$Date_Time <- paste(wData$Date, wData$Time)
wData$Date_Time <- strptime(wData$Date_Time, "%d/%m/%Y %H:%M:%S")
wData <- select(wData, -(Date:Time))

## Convert other data to numreic
cols = c(1:6)
wData[, cols] = apply(wData[, cols], 2, function(x) as.numeric(x))

## Construct Plot 1
png("./Figures/Plot1.png", width=480, height=480)
hist(wData$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
