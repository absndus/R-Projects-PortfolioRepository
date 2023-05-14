#File: 05-04-2023 R-Studio Program Vehicles Information Extractor.r
#Author: Albert Schultz
#Date: 05/04/2023
#Descriptions: This program imports the raw .data file from the UCI Machine Learning Repository that was downloaded to the computer, extracts, clean, wrangle data, and present information to graphs and charts.

#IStep 1 - Import the library modules needed for this program. 
library(readr) #Reads the CSV files.
library(dplyr) #Performs data manipulations. 
library(zoo) #Aggregation of information and data in columns.
library(data.table) #manages the data in the tables and data frames.
library(ggplot2) #Plot graphs.
library(gridExtra) #Plots multiple graphs in one image.

#Step 2 - Set the current directory to the GitHub working directory on your computer that you have created your R-project in and ensure that the csv file is within the Github windows directory as well.
setwd("~/My Labs/AI Data Scientist Trainings/GitHub Cloned Repos/RStudio Projects Real World/r-studio-projects")

###############################################Data Discovery and Loading Into R#############################################################
#Step 3 - Perform pre-loading of the data and convert it to a data frame set.
cars_raw <- read.csv("~/My Labs/AI Data Scientist Trainings/GitHub Cloned Repos/RStudio Projects Real World/r-studio-projects/imports-85.data", header=FALSE)

cars_df <- as.data.frame(cars_raw)

#Step 4 - Inspect the new data frame called, cars_df.
table(duplicated(cars_df)) 
summary(cars_df)
cat(paste(colnames(cars_df), collapse = "\n"))
#Results: As you can see above, that when the chunk of code was ran, you see that there is a list of column names from V1 to V26. Changes of column names in the data frame is a must to get a better understanding and keeping our data nice and clean. 

###############################################Perform Data Cleaning########################################################################
#Step 5 - Perform data wrangling and cleaning on the new data frame, cars_df and name the clean wrangled data frame as cars_df1. 
cars_df1 <- cars_df %>%
  mutate(
    make = cars_df$V3,
    fuel_type = cars_df$V4,
    engine_fuel_type = cars_df$V5,
    shaft_location = cars_df$V6, 
    class = cars_df$V7, 
    transmission = cars_df$V8,
    drive_location = cars_df$V9,
    engine_cam = cars_df$V15,
    engine_cyl = cars_df$V16,
    gross_weight = cars_df$V23,
    city_mpg = cars_df$V24,
    high_mpg = cars_df$V25,
    odometer = cars_df$V26
  ) %>%
  select(make, fuel_type,engine_fuel_type, shaft_location, class, transmission, drive_location, engine_cam, engine_cyl, gross_weight, city_mpg, high_mpg, odometer)

colnames(cars_df1) #Show column headers to see the changes from above.
table(duplicated(cars_df)) #Show any unique and duplicated items.
#Results: When the code was ran, you can see that the columns were properly renamed based on the various data-points in the columns. However, we see that there were several missing data that has a "?" and a "l" in them. Let's replace those with a "NA." Once completed, convert them to the proper column format to run calculations and analysis later on.

#Step 6 - Replace the ? and the l with the NA in all of the non-valued fields in the data frame set, cars_df1.
cars_df1[cars_df1 == "?"] <- NA
cars_df1[cars_df1 == "l"] <- NA
print(cars_df1)
#Results: As you can see after running the above code, the cars_df1 table shows "NA" in all of the fields that were missing data to later be populate with predicted data.

#Step 7 - Pre-populate the missing odometer miles in the fields that do not have a value at this time. Remove the decimal places and round to the nearest floor using the floor() function in R.
cars_df1$odometer <- as.numeric(cars_df1$odometer) 
summary(cars_df1) 
cars_df1$odometer <- na.aggregate(cars_df1$odometer) %>% 
  floor()
print(cars_df1)
#Results: As you can see in the view(cars_df1), the empty odometer readings for the empty fields were prepopulated with the predicted (mean) of the estimated mileages. 

#Step 8 - Pre-populate the missing gross vehicle weight in the fields that do not have a value at this time. Remove the decimal places and round to the nearest floor using the floor() function in R.
cars_df1$gross_weight <- as.numeric(cars_df1$gross_weight) 
summary(cars_df1) 
cars_df1$gross_weight <- na.aggregate(cars_df1$gross_weight) %>% 
  floor()
print(cars_df1)
#Results: As you can see, the missing gross vehicle weight has been populated with the mean of the weight of the vehicles combined. 

#Step 9 - This one was tricky, what I did as for this project, I populated them with four for the shaft-location of the vehicle and dhc for the engine_cam as a training purpose guide.
cars_df1$engine_cam[is.na(cars_df1$engine_cam)] <- "dhc"
cars_df1$shaft_location[is.na(cars_df1$shaft_location)] <- "four"

#Step 10 - Inspect the cleaned data-frame, cars_df1 to double check the work.
print(paste("The numbers of unique rows in this data set is,",table(duplicated(cars_df1)), "rows."))
print(paste("The numbers of empty fields in this data set is,",sum(is.na(cars_df1)), "fields."))

###############################################Perform EDA#################################################################################
#Step 11 - Perform a quick count of the numbers of rows and separate them based on vehicle class from the cars_df1 data frame instead of sum(nrow) of the entire data set of cars_df1.
vehicle_nrow_per_class <- cars_df1 %>%
  group_by(class) %>%
  summarize(count = n())

print(vehicle_nrow_per_class)

#Step 11a -  Graph the numbers of vehicles per class on a bar chart. I got an error saying that the png "cannot open the connection." Copy and paste the below code to an empty r-script and run it to see the bar graph with the red gradient based on the numbers of vehicles per class.
p1 <- ggplot(vehicle_nrow_per_class, aes(x = class, y = count, fill = count)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_gradient(low = "red", high = "darkred") +
  labs(title = "Numbers of Vehicles by Class", 
       subtitle = "Source: UCI Machine Learning Repository\n URL: https://archive.ics.uci.edu/ml/datasets/Automobile",
       x = "Vehicle Class", 
       y = "Numbers of Vehicles",
       fill = "Numbers of Vehicle Samples"
  )
print(p1) #View graph.

#Step 12 - EDA Hypothesis - The class of vehicles have similar miles per gallon (MPG) as the other classes. 
vehicle_mpg_by_class <- cars_df1 %>%
  group_by(class) %>%
  summarise(avg_mpg = round(sum((city_mpg+high_mpg)/2)/n(),0)) #Sum all of the average between highway + city mpg and divide by the total count of each class type. The n() is the numbers of rows separated by the class type as shown in the test chunk code below. 
print(vehicle_mpg_by_class)

#Step 12a - Graph the comparison of the avg_mpg for both city/highway across various vehicle class on the bar-chart. I got an error saying that the png "cannot open the connection." Copy and paste the below code to an empty r-script and run it to see the bar graph with the green gradient based on the mileage.
p2 <- ggplot(vehicle_mpg_by_class, aes(x = class, y = avg_mpg, fill = avg_mpg)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_gradient(low = "lightgreen", high = "darkgreen") +
  labs(title = "Average MPG by Vehicle Class", 
       subtitle = "Source: UCI Machine Learning Repository\n URL: https://archive.ics.uci.edu/ml/datasets/Automobile",
       x = "Vehicle Class", 
       y = "Average MPG(City/Highway Combined)",
       fill = "Average MPG"
  )
print(p2) #View the graph.

#Step 13 - EDA Hypothesis - The vehicle's engine type (turbo and standard) have different mpg than each other.
vehicle_mpg_by_engine_fuel_type <- cars_df1 %>%
  group_by(engine_fuel_type) %>%
  summarise(avg_mpg = round(sum((city_mpg+high_mpg)/2)/n(),0)) 
print(vehicle_mpg_by_class)

#Step 13a - Graph the comparison of the avg_mpg for both city/highway for the two engine_fuel_type on the barchart. I got an error saying that the png "cannot open the connection." Copy and paste the below code to an empty r-script and run it to see the bar graph with the orange.
p3 <- ggplot(vehicle_mpg_by_engine_fuel_type, aes(x = engine_fuel_type, y = avg_mpg)) +
  geom_bar(stat = "identity", fill = "darkorange", color = "black") +
  labs(title = "Average MPG by Engine Fuel Type", 
       subtitle = "Source: UCI Machine Learning Repository\n URL: https://archive.ics.uci.edu/ml/datasets/Automobile",
       x = "Engine Fuel Type", 
       y = "Average MPG"
  ) +
  theme_minimal()
print(p3) #View the graph.

#step 14 - EDA Hypothesis - The vehicle's odometer reading are different based on the vehicle classes and how often they were driven.
vehicle_avg_mileage_by_class <- cars_df1 %>%
  group_by(class) %>%
  summarise(avg_mileage = round(sum(odometer/n(),0)))
print(vehicle_avg_mileage_by_class)

#Step 14a - Graph te comparison between the average mileage of all of the vehicles within each vehicle class and plot them on a bar chart. I got an error saying that the png "cannot open the connection." Copy and paste the below code to an empty r-script and run it to see the bar graph with the blue gradient based on the average mileage per class.
p4 <- ggplot(vehicle_avg_mileage_by_class, aes(x = class, y = avg_mileage, fill = avg_mileage)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  labs(title = "Average Mileage by Vehicle Class", 
       subtitle = "Source: UCI Machine Learning Repository\n URL: https://archive.ics.uci.edu/ml/datasets/Automobile",
       x = "Vehicle Class", 
       y = "Average Total Mileage (Per Class)",
       fill = "Average Mileage Class"
  )
print(p4) #View the graph.

###############################################Present the Information####################################################################
#Step 15 - Create Quad View of the Created Graphs
grid.arrange(p1, p2, p3, p4, ncol = 2)