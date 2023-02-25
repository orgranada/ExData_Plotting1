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
plot(x= data$DateTime, y= data$Global_active_power,
     xlab = "", ylab = "Global Acive Power (kilowatts)",
     type = "l",
     col = "black")


dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()

