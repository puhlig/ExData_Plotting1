## Exporatory Data Analysis

## Week 1 - Peer Graded Project
##   plot3.R
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

# plot the line graph of plot3 (energysubmeetering[123] vs datetime)
with(powerCon,plot(datetime,submetering1,type="l",xlab="",ylab="Energy sub meetering",col="black"))
with(powerCon,lines(datetime,submetering2,type="l",col="red"))
with(powerCon,lines(datetime,submetering3,type="l",col="blue"))
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# copy to graphic device png
dev.copy(png,"plot3.png")
dev.off()



