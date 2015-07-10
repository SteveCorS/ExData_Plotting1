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

if (!file.exists("plot1.png")) {
  #draw plot and save to png device:
  print("drawing plot1.png")
  png(file="plot1.png")
  hist(data$Global_active_power, xlab="Global Active Power(kilowatts)", col="red", main="Global Active Power")
  dev.off() #close png device
} else {
  print("plot1.png already exists")
}

