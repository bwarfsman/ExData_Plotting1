library(lubridate)
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

## create the plot
png(filename = "plot1.png", width = 480, height = 480)
hist(mydat$Global_active_power,col='red',main='Global Active Power',xlab='Global Active Power (kilowatts)')
dev.off()
