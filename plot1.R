#Load teh packages to be used 
library(readr)

#read the data into R
mydata<-read.table("household_power_consumption.txt", header = TRUE, sep = ";",col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"), colClasses=c(rep('character',2), rep('numeric',7)),na.strings = "?",skip=66636, nrows=2880, check.names = TRUE)
#Add a new variable for DateTime
mydata$DateTime <- paste(mydata$Date, mydata$Time)
#Change the class from character to POSIXt
mydata$DateTime<-strptime(mydata$DateTime,format = "%d/%m/%Y %H:%M:%S")

#construct graphics
hist(mydata$Global_active_power,col="red", main= "Global Active Power",xlab = "Global Active Power (kilowatts")

#Save graphics to png file
dev.copy(png,file="plot1.png", width=480, height=480)
dev.off()