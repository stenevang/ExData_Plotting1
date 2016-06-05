

previouswd <- getwd()
setwd("C:/Users/theod/Documents/Git/DataScienceSpecialization/04_Exploratory_Data_Analysis/ExData_Plotting1")

# Download the data file, unzip and read into data frame only of that was not already done
if (!exists("EPCdata")) {
      dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      temp <- tempfile()
      download.file(dataurl,temp)
      print("Starting read.table - should take about 12 seconds")
      starttime <- Sys.time()
      ElectricPowerConsumptionData <- read.table(file=unz(temp, "household_power_consumption.txt"),
                                                 header=T, 
                                                 sep=";",
                                                 na.strings="?",
                                                 colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
      stoptime <- Sys.time()
      print(paste("read.table done in",round(stoptime-starttime,2),"seconds"))
      unlink(temp)
      rm(temp)
      EPCdata <- subset(ElectricPowerConsumptionData, Date == "1/2/2007" | Date == "2/2/2007")
      print("Data set subsetted down to dates 2007-02-01 and 2007-02-02")
      rm(ElectricPowerConsumptionData)
      rm(starttime)
      rm(stoptime)
      EPCdata$DateTime <- with(EPCdata, paste(Date, Time))
      EPCdata$DateTime <- strptime(EPCdata$DateTime, format="%d/%m/%Y %H:%M:%S", tz="GMT")
      print("Created DateTime column with POSIX values")
} else {
        print("The data is already loaded, now plotting.")
}

png("plot1.png", width=480, height=480, units="px")
hist(EPCdata$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()

print("plot1.png (a red histogram) was saved to disk.")

setwd(previouswd)

