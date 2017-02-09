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
target_source_data$Date <- dmy(target_source_data$Date)
target_source_data$Time <- hms(target_source_data$Time)
print("Plotting Data")
xlabel <- "Global Active Power (kilowatts)"
ylabel <- "Frequency"
graphTitle <- list("Global Active Power")
graphColor <- "red"
ylimits <- c(0, 1200)
png("plot1.png", bg="transparent")
par(mar=c(4,4,4,4))
hist(target_source_data$Global_active_power, xlab = xlabel, ylab = ylabel, main = graphTitle, col = graphColor, ylim = ylimits)
title(font.main = 2)
dev.off()
print("Plot Saved")

