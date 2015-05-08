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

# Plot 1: Histogram (Global Avtive Power)

dev.copy(png, file="Plot1.png", width=480, height=480, units = "px", family="serif")

      hist(plot_data$Global_active_power, col = "red", 
           main = "Global Active Power", 
           xlab = "Global Active Power (kilowatts)")

dev.off()
