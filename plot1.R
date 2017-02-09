## plot1.R
## Author : Elliot Francis
## Created : 2017-2-9
## Create Global Power Activity Histogram Plot

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
xlabel <- "Global Active Power (kilowatts)"
ylabel <- "Frequency"
graphTitle <- list("Global Active Power")
graphColor <- "red"
ylimits <- c(0, 1200)

#Plot Data and Save File
print("Plotting Data")
png("plot1.png", bg="transparent")
par(mar=c(4,4,4,4))
hist(target_source_data$Global_active_power, xlab = xlabel, ylab = ylabel, main = graphTitle, col = graphColor, ylim = ylimits)
title(font.main = 2)
dev.off()
print("Plot Saved")

