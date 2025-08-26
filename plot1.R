 library(data.table)
 library(lubridate)
data<-fread("household_power_consumption.txt",
            sep = ";",
            header = TRUE )[dmy(Date) %in% c("2007-02-01",
                                             "2007-02-02") ]
data$Global_active_power<-as.numeric(data$Global_active_power)
par(pin=c(3.5,3.4))
png("plot1.png", width = 480, height = 480)
 hist(data$Global_active_power,
      col = "red",
      xlab = "Global Active Power (kilowatts)",
      main = "Global Active Power")
dev.off()