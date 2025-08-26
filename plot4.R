library(data.table)
library(lubridate)
data<-fread("household_power_consumption.txt",
            sep = ";",
            header = TRUE )[dmy(Date) %in% c("2007-02-01",
                                             "2007-02-02") ]
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)
variables<-c(data$Sub_metering_1,
             data$Sub_metering_2,data$Sub_metering_3)
data$Date<-dmy(data$Date)
data[, DateTime := as.POSIXct(paste(Date, Time), 
                              format = "%Y-%m-%d %H:%M:%S")]
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
plot(data$DateTime, data$Global_active_power, 
     type="l",
     xlab = "",
     ylab = "Global Active Power(kilowatts)",
     xaxt="n")
tick_positions<-seq(min(data$DateTime),max(data$DateTime),
                    length.out = 3)
tick_labels<-c("Thu","Fri","Sat")
axis(1,at=tick_positions,tick_labels)
plot(data$DateTime,data$Voltage, type = "l",
     xlab="datetime",
     ylab="Voltage",
     xaxt="n")
axis(1,at=tick_positions,tick_labels)
plot(data$DateTime,data$Sub_metering_1,type = "l",
     ylim = range(variables),
     ylab = "Energy sub metering",
     xlab = "",
     col="black",
     xaxt = "n")
lines(data$DateTime,data$Sub_metering_2,
      col="red")
lines(data$DateTime,data$Sub_metering_3,
      col="blue")
axis(1,at=tick_positions,tick_labels)
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       lty = 1,
       cex = .6 ,bty = "n")
plot(data$DateTime,data$Global_reactive_power,
     type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime",
     xaxt="n")
axis(1,at=tick_positions,tick_labels)
dev.off()