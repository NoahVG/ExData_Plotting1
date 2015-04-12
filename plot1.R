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
png("plot1.png", width=480, height=480)
# creates histogram, sets overall and x axis labels, sets column colors
hist(data2[,3], main="Global Active Power", xlab="Global Active Power (kilowatts)", col=34, xaxt='n')
#sets x axis labels
axis(side=1, at=seq(0,6,2))
#closes device
dev.off()