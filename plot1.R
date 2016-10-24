## Exporatory Data Analysis

## Week 1 - Peer Graded Project
##   plot1.R
##
## by: Paul Uhlig

# Memory usage calculation
# Given: 2,075,529 rows by 9 columns
#     at 8bytes/entry (estimate), memory requirement approx 142Mb
# read the raw data file already extracted in working directory
filename <- "household_power_consumption.txt"
rawData1 <- read.csv2(filename,dec = ".", numerals = "no.loss", na.strings = "?")

# tidy the names of the variables
names(rawData1) <- gsub("_","",tolower(names(rawData1)))

# combine the date and time columns into a datetime column
datetime <- with(rawData1,strptime(paste(date,time),"%d/%m/%Y %H:%M:%S"))

# remove old date and time columns and append new datetime column on left of dataframe
rawData2 <- cbind(datetime,rawData1[,-(1:2)])

# subset the columns for the desired dates into dataframe powerCon
powerCon <- subset(rawData2,grepl("^2007-02-0[12]",as.character(datetime)))

# create plot1 as shown (i.e. frequency histogram of globalactivepower variable)
with(powerCon,hist(globalactivepower,col="red",xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power"))

# Copy image from screen to png device
dev.copy(png,"plot1.png")
dev.off()


