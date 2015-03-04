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

## Construct Plot 4
png("./Figures/Plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(wData, {
  plot(Date_Time, Global_active_power, type="l", main="", xlab="", ylab="Global Active Power")
  plot(Date_Time, Voltage, type="l", main="", xlab="datetime", ylab="Voltage")
  with(wData, {
    plot(Date_Time, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
    lines(Date_Time, Sub_metering_1, lty=1)
    lines(Date_Time, Sub_metering_2, lty=1, col="red")
    lines(Date_Time, Sub_metering_3, lty=1, col="blue")
    legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=0.5)
  })
  plot(Date_Time, Global_reactive_power, type="l", main="", xlab="datetime", ylab="Global_reactive_power")
})

dev.off()
par(las = 0)