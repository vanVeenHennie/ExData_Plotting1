# laod the libraries to be used

library(readr)


#Read the file into R
mydata<-read.table("household_power_consumption.txt", header = TRUE, sep = ";",col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"), colClasses=c(rep('character',2), rep('numeric',7)),na.strings = "?",skip=66636, nrows=2880, check.names = TRUE)
#Add a new variable for DateTime
mydata$DateTime <- paste(mydata$Date, mydata$Time)
#Change the class from character to POSIXt
mydata$DateTime<-strptime(mydata$DateTime,format = "%d/%m/%Y %H:%M:%S")



#set 2 columns and two rows
par(mfrow= c(2,2))
#Construct graphics
with (mydata,{
  plot(DateTime,Global_active_power,  type = "l",ylab = "Global active power",xlab="")
  plot(DateTime,Voltage, type = "l",ylab = "Global active power",xlab="")
  
  with (mydata,plot(DateTime,Sub_metering_1,type = "n",ylab = "Energy sub metering",xlab=""))
  with (mydata,lines(DateTime,Sub_metering_1,type ="l",col="black"))
  with (mydata,lines(DateTime,Sub_metering_2,type ="l",col="red"))
  with (mydata,lines(DateTime,Sub_metering_3,type ="l", col="blue"))
  legend("topright",lty=1,col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(DateTime,Global_reactive_power,  type = "l",ylab = "Global reactive power",xlab="") 
})
#save the graphics to a png file

dev.copy(png,file="plot4.png", width=480, height=480)
dev.off()