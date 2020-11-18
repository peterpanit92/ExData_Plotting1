## Load data into a data frame called "epc"

epc <- read.table("household_power_consumption.txt", header=TRUE,
                  sep=";", na.strings="?", colClasses=c(
                    'character', 'character', 'numeric', 
                    'numeric', 'numeric', 'numeric', 'numeric',
                    'numeric', 'numeric'))

## Change the format of date columns to date

epc$Date <- as.Date(epc$Date, "%d/%m/%Y")


## Filter dtata from Feb. 1 20077 to Feb. 2, 2007

epc <- subset(epc, Date >= as.Date("2007-2-1") & 
                Date <= as.Date("2007-2-2"))

## REmove incomplete observations

epc <- epc[complete.cases(epc),]

## Combine Date and Time column
dateTime <- paste(epc$Date, epc$Time)

## Name the Vector
dateTime <- data.frame(dateTime)

dateTime <- setNames(dateTime, "DateTime")

## Remove data and time columns from epc

epc <- epc[ , !(names(epc) %in% c("Date", "Time"))]

## Combine epc and DateTime column
epc <- cbind(dateTime, epc)

## Format dateTime column
epc$DateTime <- as.POSIXct(epc$DateTime)

## CREATE PLOT 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(epc, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()