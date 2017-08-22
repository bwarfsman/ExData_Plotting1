## Dowload data
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',dest='data.zip',method='curl')

## Unzip data to working directory
unzip('data.zip',exdir='./')

## Read data to table
mydat<-read.table('household_power_consumption.txt',sep=';',header=TRUE,stringsAsFactors = FALSE)

#convert character date to date class
mydat$Date<-dmy(mydat$Date)

## remove all data except for data from 2/1/2007 and 2/2/2007
mydat<-subset(mydat,mydat$Date=='2007-02-01' | mydat$Date=='2007-02-02')

## Convert columns 3 through 9 to numbers
mydat[, 3:9] <- sapply(mydat[, 3:9], as.numeric)

## Combine date and time to one field and delete time
mydat$Date<-as.POSIXct(paste(mydat$Date, mydat$Time), format="%Y-%m-%d %H:%M:%S")
colnames(mydat)[1]<-"DateTime"
mydat<-mydat[,c(1,3:9)]

## create the plot
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))

plot(mydat$DateTime,mydat$Global_active_power,type='n',xlab='',ylab='Global Active Power')
lines(mydat$DateTime,mydat$Global_active_power,type='l')

plot(mydat$DateTime,mydat$Voltage,type='n',xlab='datetime',ylab='Voltage')
lines(mydat$DateTime,mydat$Voltage,type='l')

plot(mydat$DateTime,mydat$Sub_metering_1,type='n',xlab='',ylab='Energy sub metering')
lines(mydat$DateTime,mydat$Sub_metering_1,type='l')
lines(mydat$DateTime,mydat$Sub_metering_2,type='l',col='red')
lines(mydat$DateTime,mydat$Sub_metering_3,type='l',col='blue')
legend('topright',c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),col=c('black','red','blue'),lty=1,lwd=2)

plot(mydat$DateTime,mydat$Global_reactive_power,type='n',xlab='datetime',ylab='Global_reactive_power')
lines(mydat$DateTime,mydat$Global_reactive_power,type='l')

dev.off()

