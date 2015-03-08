Sys.setlocale("LC_TIME", "English") 

# file is located in subfolder ExplAnalysis under working directory
filepath <- "ExplAnalysis\\household_power_consumption.txt"
df <- read.csv(filepath, header=TRUE, sep=';', stringsAsFactors=FALSE)

# Convert to Date format
df$Date <-as.Date( df$Date, format="%d/%m/%Y")

# merge date and time, then convert to datetime
df$Time <- strptime(paste(df$Date,df$Time), format="%Y-%m-%d %H:%M:%S")

# only use 2 days
df2007 <- subset(df, Date %in% as.Date(c('2007-02-01', '2007-02-02')))

# open device for png output
png(filename="ExplAnalysis\\plot4.png")

# set up the canvas for 2x2 graphs
par(mfcol = c(2,2))
with(df2007, {
    # plot global active power
    plot(df2007$Time, as.numeric(df2007$Global_active_power), xlab="", ylab="Global Active Power", type="n")
    lines(df2007$Time, as.numeric(df2007$Global_active_power))
    
    # plor Energy sub metering
    plot(df2007$Time, as.numeric(df2007$Sub_metering_1), xlab="", ylab="Energy sub metering", type="n")
    lines(df2007$Time, as.numeric(df2007$Sub_metering_1))
    lines(df2007$Time, as.numeric(df2007$Sub_metering_2), col="red")
    lines(df2007$Time, df2007$Sub_metering_3, col="blue")
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", col=c("black", "red", "blue"), lty=1)    
    
    # plot voltage
    plot(df2007$Time, as.numeric(df2007$Voltage), xlab="datetime", ylab="Voltage", type="n")
    lines(df2007$Time, as.numeric(df2007$Voltage))
    
    # plot reactive power
    plot(df2007$Time, as.numeric(df2007$Global_reactive_power), xlab="datetime", ylab="Global_Reactive_Power", type="n")
    lines(df2007$Time, as.numeric(df2007$Global_reactive_power), lwd=0.01)
})

#close device
dev.off()
