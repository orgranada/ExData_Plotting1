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

#MAKE PLOT AND EXPORT
hist(data$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
     col = "red",
     )

dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()
