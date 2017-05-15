
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



## figure 2
png("plot2.png", width = 480, height = 480)
plot(data_sub$DateTimeval,data_sub$Global_active_power,  type = "l", ylab = "Global Active Power (kilowatts)", xlab ="")
dev.off()

