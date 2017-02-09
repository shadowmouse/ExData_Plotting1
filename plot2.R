library(readr)
library(dplyr)
library(lubridate)
print("Loading Dataset")
columnDfns = list(col_character(), col_character(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double())

# Data Caching
if(!exists('household_source_data')) {
  print("Source Data Not Loaded. Loading...")
  household_source_data <- read_delim("./household_power_consumption.txt", ";", col_types = columnDfns)  
} else {
  print("Source Data Loaded from Previous Run. Using Loaded Data...")
}
print("Filtering for Target Date Range")
target_source_data <- filter(household_source_data, Date == '1/2/2007'  | Date == '2/2/2007')
print("Converting Date and Time Columns")
target_source_data$DateTime <- dmy_hms(paste(target_source_data$Date," ",target_source_data$Time))
target_source_data$Date <- dmy(target_source_data$Date)
target_source_data$Time <- hms(target_source_data$Time)
print("Plotting Data")
xlabel <- ""
ylabel <- "Global Active Power (kilowatts)"
graphTitle <- list("Global Active Power")
graphColor <- "red"
png("plot2.png", bg="transparent")
plot(type="l", target_source_data$DateTime, target_source_data$Global_active_power,  xlab = xlabel, ylab = ylabel)
title(font.main = 2)
dev.off()
print("Plot Saved")

