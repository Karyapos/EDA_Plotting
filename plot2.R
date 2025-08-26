library(data.table)
library(lubridate)
data<-fread("household_power_consumption.txt",
            sep = ";",
            header = TRUE )[dmy(Date) %in% c("2007-02-01",
                                             "2007-02-02") ]
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Date<-dmy(data$Date)
data[, DateTime := as.POSIXct(paste(Date, Time), 
                              format = "%Y-%m-%d %H:%M:%S")]
par(pin=c(3.5,3.4))
png("plot2.png", width = 480, height = 480)
plot(data$DateTime, data$Global_active_power, 
     type="l",
     xlab = "",
     ylab = "Global Active Power(kilowatts)",
     xaxt="n")
tick_positions<-seq(min(data$DateTime),max(data$DateTime),
                    length.out = 3)
tick_labels<-c("Thu","Fri","Sat")
axis(1,at=tick_positions,tick_labels)
dev.off()