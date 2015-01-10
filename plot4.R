
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


# Making Plot 3 ----------------------------------------------------------

#open PNG graph device
png(filename = "plot4.png",
    width = 480, height = 480)

#setting device parameters
par(mfcol=c(2,2))

#plotting [1,1]
        plot(dat$Timestamp, dat$Global_active_power, 
             type = "l",
             col ="black",
             main = "",
             xlab = "",
             ylab ="Global Active Power"
             )

#plotting [2,1]
        #plotting graph canvas
        plot(dat$Timestamp, dat$Sub_metering_1,
             type = "n",
             main = "",
             xlab = "",
             ylab ="Energy sub metering"
             )
        
        #plotting data
        lines (dat$Timestamp,dat$Sub_metering_1, col="black")
        lines (dat$Timestamp,dat$Sub_metering_2, col="red")
        lines (dat$Timestamp,dat$Sub_metering_3, col="blue")
        
        #plotting legend
        legend("topright", 
               legend = colnames(dat)[6:8], 
               lty=1, 
               col=c("black","red","blue"),
               bty="n"
               )

#plotting [1,2]
        plot(dat$Timestamp, dat$Voltage, 
             type = "l",
             col ="black",
             main = "",
             xlab = "datetime",
             ylab ="Voltage"
             )

#plotting [2,2]
        plot(dat$Timestamp, dat$Global_reactive_power, 
             type = "l",
             col ="black",
             main = "",
             xlab = "datetime",
             ylab ="Global_reactive_power"
             )


#close the device
dev.off()
