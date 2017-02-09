## plot3.R
## Author : Elliot Francis
## Created : 2017-2-9
## Create Energy Sub Metering Plot

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
xlabel <- ""
ylabel <- "Energy sub metering"
plotColors <- c("black", "red", "blue")

#Create Matrix Data from Power Sub Metering Data
yData <- data.frame(target_source_data$Sub_metering_1, target_source_data$Sub_metering_2, target_source_data$Sub_metering_3)

#Plot Data and Save File
png("plot3.png", bg="transparent")
par(mar=c(4,4,4,4))
matplot(type="l", target_source_data$DateTime, yData,  xlab = xlabel, ylab = ylabel, col = plotColors, lty = 1, xaxt="n")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = plotColors, lty = 1)
# Note : Extra 1000 Added to DateTime Max to encompass Saturday Start Date
axis.POSIXct(1, at=seq(min(target_source_data$DateTime), max(target_source_data$DateTime) + 1000, by="days"), format="%a")
dev.off()
print("Plot Saved")

