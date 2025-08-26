library(data.table)
library(lubridate)
data<-fread("household_power_consumption.txt",
            sep = ";",
            header = TRUE )[dmy(Date) %in% c("2007-02-01",
                                             "2007-02-02") ]
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)
variables<-c(data$Sub_metering_1,
             data$Sub_metering_2,data$Sub_metering_3)
data$Date<-dmy(data$Date)
data[, DateTime := as.POSIXct(paste(Date, Time), 
                              format = "%Y-%m-%d %H:%M:%S")]
par(pin=c(3.5,3.4))
png("plot3.png", width = 480, height = 480)
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
tick_positions<-seq(min(data$DateTime),max(data$DateTime),
                    length.out = 3)
tick_labels<-c("Thu","Fri","Sat")
axis(1,at=tick_positions,tick_labels)
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       lty = 1,
       cex = 1)
dev.off()