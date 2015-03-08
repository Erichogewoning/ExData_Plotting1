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
png(filename="ExplAnalysis\\plot1.png")

#plot the histogram
hist(as.numeric(df2007$Global_active_power), col="red", main="Global Active Power", xlab="Global Active Power(kilowatts)")

#close device
dev.off()