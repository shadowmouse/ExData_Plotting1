## plot4.R
## Author : Elliot Francis
## Created : 2017-2-9
## Create Composite Graph of Global Active Power, Voltage, Sub Metering, and Reactive Power

# Load Support Libraries
library(readr)
library(dplyr)
library(lubridate)
print("Loading Dataset")

#Specify Column Defintions
columnDfns = list(col_character(), col_character(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double())

# Data Loading/Caching
if(!exists('household_source_data')) {
  print("Source Data Not Loaded. Loading...")
  household_source_data <- read_delim("./household_power_consumption.txt", ";", col_types = columnDfns)  
} else {
  print("Source Data Loaded from Previous Run. Using Loaded Data...")
}

#Get Target Data Range
print("Filtering for Target Date Range")
target_source_data <- filter(household_source_data, Date == '1/2/2007'  | Date == '2/2/2007')

# Convert Date/Time Columns -- Add Datetime Column
print("Converting Date and Time Columns")
target_source_data$DateTime <- dmy_hms(paste(target_source_data$Date," ",target_source_data$Time))
target_source_data$Date <- dmy(target_source_data$Date)
target_source_data$Time <- hms(target_source_data$Time)

#Plot Configuration Varaibles
print("Plotting Data")

#Plot Data and Save File
png("plot4.png", bg="transparent")

# Set Plot Grid
par(mar=c(4,4,4,4))
par(mfrow=c(2,2))

#Plot 1
xlabel <- ""
ylabel <- "Global Active Power (kilowatts)"
plot(type="l", target_source_data$DateTime, target_source_data$Global_active_power,  xlab = xlabel, ylab = ylabel)
title(font.main = 2)

#Plot 2
xlabel <- "Datetime"
ylabel <- "Voltage"
plot(type="l", target_source_data$DateTime, target_source_data$Voltage,  xlab = xlabel, ylab = ylabel)
title(font.main = 2)

#Plot 3
xlabel <- ""
ylabel <- "Energy sub metering"
plotColors <- c("black", "red", "blue")
yData <- data.frame(target_source_data$Sub_metering_1, target_source_data$Sub_metering_2, target_source_data$Sub_metering_3)
matplot(type="l", target_source_data$DateTime, yData,  xlab = xlabel, ylab = ylabel, col = plotColors, lty = 1, xaxt="n")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = plotColors, lty = 1, bty = "n", cex=0.8)
# Note : Extra 1000 Added to DateTime Max to encompass Saturday Start Date
axis.POSIXct(1, at=seq(min(target_source_data$DateTime), max(target_source_data$DateTime) + 1000, by="days"), format="%a")

#Plot 4
xlabel <- "Datetime"
ylabel <- "Global Reactive Power"
plot(type="l", target_source_data$DateTime, target_source_data$Global_reactive_power,  xlab = xlabel, ylab = ylabel)
title(font.main = 2)

dev.off()
print("Plot Saved")

