setwd("~/Coursera/exdata")

hpc <- read.table("./exdata_data_household_power_consumption/household_power_consumption.txt", 
            header=TRUE, sep=";", stringsAsFactors=FALSE)


## convert the Date and Time variables to Date/Time classes
## convert characters to numbers
hpc <- cbind(
            datetime = strptime(paste(hpc$Date, hpc$Time),"%d/%m/%Y %H:%M:%S"),
            as.data.frame(sapply(hpc[,c(3:9)], as.numeric)) 
            )

## Filter Plot Data for specified dates
start_date <- strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S")
end_date   <- strptime("2007-02-02 23:59:59", "%Y-%m-%d %H:%M:%S")

plot_data  <- hpc[hpc$datetime >= start_date &  
                    hpc$datetime <= end_date, ]

old_par    <- par()

# Plot 4: Multiple Plots

dev.copy(png, file="Plot2.png", width=480, height=480, units = "px", family="serif")

    par(mfrow = c(2,2), oma = c(0,0,2,0), cex = 0.6 )
    
            with(plot_data,{
              
              # PLOT: Top Right
              plot(datetime, Global_active_power, type = "l",
                   ylab = "Global Active Power", xlab = "")
              
              
              # PLOT: Top Left 
              plot(datetime, Voltage, type = "l")
              
              
              # PLOT: Bottom Right
              plot(datetime, Sub_metering_1, type = "l",
                   ylab = "Energy Sub Metering", xlab = "")
              
              lines(datetime, Sub_metering_2, col = "red")                   
              lines(datetime, Sub_metering_3, col = "blue")
              
              legend("topright", bty = "n", pch="_", 
                   col= c("black", "red", "blue"),  
                   legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
              
              
              # PLOT: Bottom Left
              plot(datetime, Global_reactive_power, type = "l")
            })
  
    par(old_par)

dev.off()
    

