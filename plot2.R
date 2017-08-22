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

mydat$Date<-as.POSIXct(paste(mydat$Date, mydat$Time), format="%Y-%m-%d %H:%M:%S")

colnames(mydat)[1]<-"DateTime"
mydat<-mydat[,c(1,3:9)]

png(filename = "plot2.png", width = 480, height = 480)
plot(mydat$DateTime,mydat$Global_active_power,type='n',xlab='',ylab='Global Active Power (kilowatts)')
lines(mydat$DateTime,mydat$Global_active_power,type='l')
dev.off()

