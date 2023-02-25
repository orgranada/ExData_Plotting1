#GET DATA
##Download data
zipurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(zipurl, destfile = "./data.zip", method = "curl")
#Unzip data
unzip("./data.zip")

#READ DATA
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                   na.strings = "?", )
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
dtime <- paste(data$Date, data$Time)
data$DateTime <- strptime(dtime, format = "%Y-%m-%d %H:%M:%S")
data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

#Coding this while in Paraguay. Need to change Locale to English in order to
#match the xlab language
Sys.setlocale("LC_TIME", "en_US")
#Sys.setlocale("LC_TIME", "Spanish_Paraguay.1252")

#MAKE PLOT AND EXPORT
plot(x= data$DateTime, y= data$Sub_metering_1,
     xlab= "", ylab= "Engergy sub metering",
     type= "l",
     col = "black",
     main= ""
     )
lines(x= data$DateTime, y= data$Sub_metering_2, 
      col = "red")
lines(x= data$DateTime, y= data$Sub_metering_3, 
      col = "blue")
legend("topright",
       col = c("black", "red", "blue"),
       lty = 1,
       lwd = 1,
       legend = c("Sub_metering_1     ", "Sub_metering_2    ", "Sub_metering_3     "),
       #Spaces are a workaround to avoid text cropping when exporting
       x.intersp = 0.3,
       seg.len = 1
       )

dev.copy(png, "plot3.png", width = 480, height = 480)
dev.off()
