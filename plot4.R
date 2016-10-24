## Exporatory Data Analysis

## Week 1 - Peer Graded Project
##   plot4.R
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

# plot four graphs in a 2x2 lattice... using base plotting... will fill by column...
par(mfcol=c(2,2))
with(powerCon, {
      # (1,1)-graph
      # plot the line graph of plot2 (Global Active Power vs datetime)
      plot(datetime,globalactivepower,type="l", cex.lab=0.75, xlab="",ylab="Global Active Power")
      
      # (2,1)-graph
      # plot the line graph of plot3 (energysubmeetering[123] vs datetime)
      plot(datetime,submetering1,type="l", cex.lab=0.75, xlab="",ylab="Energy sub meetering",col="black")
      lines(datetime,submetering2,type="l",col="red")
      lines(datetime,submetering3,type="l",col="blue")
      legend("topright", cex=0.7, bty="n", lty=1, col = c("black", "blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
      
      # (1,2)-graph
      # plot voltage vs datetime
      plot(datetime,voltage,type="l", cex.lab=0.75, ylab="Voltage")
      
      # (2,2)-graph
      # plot globalreactivepower vs datetime
      plot(datetime,globalreactivepower,type="l", cex.lab=0.75, ylab="Global_reactive_power")
})

# copy to graphic device png
dev.copy(png,"plot4.png")
dev.off()



