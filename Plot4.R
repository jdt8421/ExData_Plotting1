
setwd(loc)
require(lubridate)

data = read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
data$Date = dmy(data$Date)

data$Date = as.Date(data$Date)



## select the two days wanted
data_sub = data[data$Date == ymd(20070201),]
data_sub = rbind(data_sub,data[data$Date == ymd(20070202),] )

## create a date-time field (only for subset to speed up)
data_sub$DateTimeval = as.POSIXct(paste(data_sub$Date, data_sub$Time))


png("plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))

plot(data_sub$DateTimeval,data_sub$Global_active_power,  type = "l", ylab = "Global Active Power", xlab ="")
plot(data_sub$DateTimeval,data_sub$Voltage,  type = "l", ylab = "Voltage", xlab ="datetime")
yrange = range(c(data_sub$Sub_metering_1,data_sub$Sub_metering_2,data_sub$Sub_metering_3 ))
plot(data_sub$DateTimeval,data_sub$Sub_metering_1,  type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab ="", ylim = yrange)
lines(data_sub$DateTimeval, data_sub$Sub_metering_2, type = "l", col = "red")
lines(data_sub$DateTimeval, data_sub$Sub_metering_3, type = "l", col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3") ,
       col = c("black", "red","blue"), lty = 1)
plot(data_sub$DateTimeval,data_sub$Global_reactive_power,  type = "l", ylab = "Global_reactive_power", xlab ="datetime")

dev.off()
par(mfrow=c(1,1))

