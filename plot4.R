if (file.exists("household_power_consumption.txt")) { #check for .txt file
  #read in dataframe:
  print("household_power_consumption.txt found, reading dataset in dataframe")
  data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")
} else if (file.exists("exdata-data-household_power_consumption.zip")) #check for .zip file
{
  #unzip and read in data frame:
  print("exdata-data-household_power_consumption.zip found, unziping file and reading dataset in dataframe")
  data <- read.table(unz("exdata-data-household_power_consumption.zip", "household_power_consumption.txt"), sep=";", header=TRUE, na.strings="?")
} else {
  #download file, unzip and read in data frame :
  print("no file for dataset found, downloading dataset")
  tempFile <- tempfile()
  url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, tempFile)
  print("reading dataset in dataframe")
  data <- read.table(unz(tempFile, "household_power_consumption.txt"), sep=";", header=TRUE, na.strings="?")
  unlink(tempFile)
}

data <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007",]
#add combined datetimte column to dataframe:
timezone <- Sys.getlocale() 
Sys.setlocale("LC_TIME", "English") #english weekdays
data$Datetime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")


if (!file.exists("plot4.png")) {
  #draw plot and save to png device:
  print("drawing plot4.png")
  png(file="plot4.png")
  par(mfrow = c(2, 2))
  with(data, {
    plot(Datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power")
    plot(Datetime, Voltage, type="l", xlab="datetime", ylab="Voltage")
    plot(Datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    lines(Datetime, Sub_metering_2, col="red")
    lines(Datetime, Sub_metering_3, col="blue")
    legend("topright", lty=1, pch = "", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.70, bty = "n")
    plot(Datetime, Global_reactive_power, yaxt="n", type="l", xlab="datetime", ylab="Global_reactive_power", cex.lab=0.75)
    axis(2, at=c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5), labels=c("0.0", "0.1", "0.2", "0.3", "0.4", "0.5"), las=0, cex.axis=0.7)
  })
  dev.off() #close png device
} else {
  print("plot4.png already exists")
}

Sys.setlocale("LC_TIME") #back to normal time