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
png(filename="ExplAnalysis\\plot2.png")
# set up the plot details, but suppress plotting the dots
plot(df2007$Time, as.numeric(df2007$Global_active_power), xlab="", ylab="Global Active Power(kilowatts)", type="n")
#plot the lines
lines(df2007$Time, as.numeric(df2007$Global_active_power))
#close device
dev.off()