#sets directory to location of data
setwd("C:/Users/Noah/Documents/Exploratory Data Analysis")
#imports data into r
data <- read.table ("household_power_consumption.txt",header=TRUE, sep=";")
#changes data and time columns into r Date/Time formats and adds a date+ time column
data$Date_Time <-paste(data$Date,data$Time, sep = " ")
data$Date <- as.Date(data$Date,"%d/%m/%Y")
data$Date_Time <-format(data$Date_Time, "%d/%m/%Y %H:%M:%S")
data$Date_Time <-strptime(data$Date_Time, "%d/%m/%Y %H:%M:%S")
#subsets only 2007-21-02 and 2007-02-02 dates
data2 <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
#changes energy information into numeric class 
data2[,c(3:9)] <-sapply(data2[,c(3:9)], as.character)
data2[,c(3:9)] <-sapply(data2[,c(3:9)], as.numeric)

#creates a png file w/ specified dimensions
png("plot4.png", width=480, height=480)
#tells R to put 4 plots in one window
par(mfrow=c(2,2))
with(data2, {
  #first plot
  plot(Date_Time, Global_active_power, xlab = " ", ylab="Global Active Power",type="l")
  #second plot
  plot(Date_Time,Voltage, xlab="datetime", ylab="Voltage", type="l")
  #third plot
  plot(Date_Time, Sub_metering_1,xlab = " ", ylab = "Energy sub metering", type="n")
  lines(Date_Time,Sub_metering_1)
  lines(Date_Time,Sub_metering_2, col="red")
  lines(Date_Time, Sub_metering_3, col="blue")
  legend("topright",lty=c(1,1,1), col=c("black","red","blue"), bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  #fourth plot
  plot(Date_Time, Global_reactive_power, xlab="datetime", type="l")
})
#closes device
dev.off()