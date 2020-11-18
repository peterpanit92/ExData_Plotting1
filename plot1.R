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

## CREATE PLOT 1
hist(epc$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (Kilowatts)", col = "red")
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()

