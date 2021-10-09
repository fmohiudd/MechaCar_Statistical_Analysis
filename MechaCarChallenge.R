## ------DELIVERABLE 1 ----------
#Import and load dplyr library
library(dplyr)

# Read the data file
data_table <- read.csv(file='MechaCar_mpg.csv', check.names = F, stringsAsFactors = F )
head(data_table)

# Perform multiple linear regression, pass in all six variables, 
# data_table is the data parameter
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle +
     ground_clearance + AWD, data = data_table)

# Use summary() function to determine the p-value and r-squared value for the 
# linear regression model.
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle +
             ground_clearance + AWD, data = data_table))

## ------DELIVERABLE 2 --------
# Read the data file for Suspension coil
suspension <- read.csv(file='Suspension_Coil.csv', check.names = F, stringsAsFactors = F)
head(suspension)

# Summarize PSI 
total_summary <- suspension %>% summarize(MEAN=mean(PSI), MEDIAN=median(PSI), VARIANCE=var(PSI), SD=sd(PSI), .groups = 'keep')

# Group the PSI Column by the lot and calculate summary
lot_summary <- suspension %>% group_by(Manufacturing_Lot) %>% summarize(MEAN=mean(PSI), MEDIAN=median(PSI), VARIANCE=var(PSI), SD=sd(PSI), .groups = 'keep')
