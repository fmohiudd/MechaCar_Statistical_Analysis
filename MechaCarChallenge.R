## ------DELIVERABLE 1 ----------
#Import and load dplyr library
library(dplyr)

# Read the data file
dtbl <- read.csv(file='MechaCar_mpg.csv', check.names = F, stringsAsFactors = F )
head(dtbl)

# Perform multiple linear regression, pass in all six variables, 
# data_table is the data parameter
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle +
     ground_clearance + AWD, data = dtbl)

# Use summary() function to determine the p-value and r-squared value for the 
# linear regression model.
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle +
             ground_clearance + AWD, data = dtbl))

#--------Delv 1: EXTRA WORK-----
mpgs <- lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle +
                  ground_clearance + AWD, data = dtbl)  # Create linear model

# Determine the x-axis values from linear model
xvals <- mpgs$coefficients['vehicle_length']*dtbl$vehicle_length +
  mpgs$coefficients['vehicle_weight']*dtbl$vehicle_weight + 
  mpgs$coefficients['spoiler_angle']*dtbl$spoiler_angle + 
  mpgs$coefficients['ground_clearance']*dtbl$ground_clearance +
  mpgs$coefficients['AWD']*dtbl$AWD

yvals <- xvals -1.040e+02

library(ggplot2)

# plot the data
plt <- ggplot(dtbl, aes(x=xvals, y=mpg))
plt + geom_point() + geom_line(aes(y=yvals), color = "red") + 
  xlab("Collective Variable") + ylab("Miles per Gallon")
#--------------------

## ------DELIVERABLE 2 --------
# Read the data file for Suspension coil
suspension <- read.csv(file='Suspension_Coil.csv', check.names = F, stringsAsFactors = F)
head(suspension)

# Summarize PSI 
total_summary <- suspension %>% summarize(MEAN=mean(PSI), MEDIAN=median(PSI), VARIANCE=var(PSI), SD=sd(PSI), .groups = 'keep')

# Group the PSI Column by the lot and calculate summary
lot_summary <- suspension %>% group_by(Manufacturing_Lot) %>% summarize(MEAN=mean(PSI), MEDIAN=median(PSI), VARIANCE=var(PSI), SD=sd(PSI), .groups = 'keep')

##-----Delv 2: Extra work -----------
# Create a box plot
plt <- ggplot(suspension, aes(x=Manufacturing_Lot, y=PSI)) #import dataset into ggplot2
plt + geom_boxplot() + xlab("Manufacturing Lot") + 
  geom_point() #overlay scatter plot
##-------------------------


##------DELIVERABLE 3-----------
# Write a t.test to determine if PSI value across all the manufacturing
# lot is statistically different from the population mean, 1500 PSI

t.test(suspension$PSI,mu=1500)

#t.test to determine if the PSI for each manufacturing is statistically different.
# Select Lot1
Lot1_set <- subset(suspension, Manufacturing_Lot == 'Lot1')
t.test(Lot1_set$PSI, mu=1500)

# Select Lot2
Lot2_set <- subset(suspension, Manufacturing_Lot == 'Lot2')
t.test(Lot2_set$PSI, Lot1_set$PSI, mu=0)

t.test(Lot2_set$PSI, mu=1500)

# Select Lot3
Lot3_set <- subset(suspension, Manufacturing_Lot == 'Lot3')
t.test(Lot3_set$PSI, mu=1500)

##----DELIVERABLE 4 work-----------
#Compare fuel efficiency from the mpg(built in R) data and MechaCar mpg
other_mpg <- mpg$hwy  #select mpg only from the mpg data
mecha_mpg <- dtbl$mpg #select mpg only from MechaCar data
t.test(other_mpg, mecha_mpg) #compare the fuel efficiency

#Make a boxplot of the fuel-efficiency of the two data
other_hwy <- mpg %>% group_by(manufacturer) %>% summarize(mpg=hwy)

#Boxplot of the MechaCar fuel effciency
plt2 <- ggplot(dtbl, aes( y=mpg))
plt2 + geom_boxplot(color = "blue") + xlab("MechaCar") + 
  ggtitle("Fuel Efficiency") + theme(plot.title = element_text(hjust = 0.5)) +
  ylim(10, 80)

# Box plot of other car's fuel efficiency
plt1 <- ggplot(other_hwy, aes(x=manufacturer, y=mpg, color=manufacturer))
plt1 + geom_boxplot() + theme(axis.text.x=element_text(angle=45, hjust=1)) +
  ggtitle("Fuel Efficiency") + theme(plot.title = element_text(hjust = 0.5)) +
  ylim(10,80)

