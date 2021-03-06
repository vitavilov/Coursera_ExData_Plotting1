
# Loading data and making dataset -----------------------------------------


#read data from file (using <skip> and <nrows> for subsetting 1-2 Feb 2007)
a <- read.table(file = "household_power_consumption.txt",
                sep = ";",  na.strings = "?",
                skip = 66637,nrows = 2880,
                col.names = c("Date","Time","Global_active_power",
                             "Global_reactive_power","Voltage","Global_intensity",
                             "Sub_metering_1","Sub_metering_2","Sub_metering_3"
                             )
                )
#transform Time and Date to POSIXlt timestamp and create a dataset named <dat>
Timestamp <- strptime(x = paste(a$Date,a$Time), format = "%d/%m/%Y %H:%M:%S")
dat <- cbind(Timestamp, a[,3:9])
rm (Timestamp, a)


# Making Plot 2 ----------------------------------------------------------

#open PNG graph device
png(filename = "plot2.png",
    width = 480, height = 480)

#plotting 
plot(dat$Timestamp, dat$Global_active_power, 
     type = "l",
     col ="black",
     main = "",
     xlab = "",
     ylab ="Global Active Power (kilowatts)"
     )

#close the device
dev.off()
