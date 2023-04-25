#### Iterative Coding Lecture Notes ####
#### Created by: Mikayla Kerchen
#### Updated on: 2023-04-25
#################################

#### Load Libraries ####

library(tidyverse)
library(here)

#### Simple For Loop ####

print(paste("The year is", 2000))

# Put it in a for loop:

years <- c(2015:2021)

for (i in years){ #Set up the for loop where 'i' is the index
  print(paste("The year is", i)) #Loop over 'i'
}

# Pre-allocate space for the for loop

# Empty matrix

year_data<-data.frame(matrix(ncol = 2, nrow = length(years)))

# Add column names

colnames(year_data) <- c("year", "year_name")

year_data

# Add the for loop

for (i in 1:length(years)){ #Set up the for loop where 'i' is the index
  year_data$year_name[i]<-paste("The year is", years[i]) #Loop over 'i'
}

year_data

# Fill in the year column too

for (i in 1:length(years)){ # set up the for loop where i is the index
  year_data$year_name[i]<-paste("The year is", years[i]) # loop over year name
  year_data$year[i]<-years[i] # loop over year
}

year_data

#### Using loops to red in multiple .csv files ####

testdata<-read_csv(here("Week_13", "Data", "cond_data","011521_CT316_1pcal.csv"))

glimpse(testdata)

# List files in a directory

# Point to the location on the computer of the folder

CondPath<-here("Week_13", "Data", "cond_data")

# list all the files in that path with a specific pattern
# In this case we are looking for everything that has a .csv in the filename
# you can use regex to be more specific if you are looking for certain patterns in filenames

files <- dir(path = CondPath,pattern = ".csv")

files

# Pre-allocate space

# Make an empty data frame that has one row for each file and 3 columns

Cond_Data<-data.frame(matrix(nrow = length(files), ncol = 3))

# Give the data frame column names

colnames(Cond_Data) <- c("filename","mean_temp", "mean_sal")

Cond_Data

Raw_Data <- read_csv(paste0(CondPath,"/",files[1])) #Test by reading in the first file and see if it works

head(Raw_Data)

mean_temp <- mean(Raw_Data$Temperature, na.rm = TRUE) #Calculate a mean

mean_temp

#### Turn it into a for loop ####

for (i in 1:length(files)){ # loop over 1:3 the number of files
}

# Add in the loop over raw data

for (i in 1:length(files)){ # loop over 1:3 the number of files 
  raw_data<-read_csv(paste0(CondPath,"/",files[i]))
  glimpse(raw_data)
}

# Add in the columns

for (i in 1:length(files)){ # loop over 1:3 the number of files 
  raw_data<-read_csv(paste0(CondPath,"/",files[i]))
  #glimpse(raw_data)
  Cond_Data$filename[i]<-files[i]
} 

Cond_Data

# Add in means

for (i in 1:length(files)){ # loop over 1:3 the number of files 
  raw_data<-read_csv(paste0(CondPath,"/",files[i]))
  #glimpse(raw_data)
  Cond_Data$filename[i]<-files[i]
  Cond_Data$mean_temp[i]<-mean(raw_data$Temperature, na.rm =TRUE)
  Cond_Data$mean_sal[i]<-mean(raw_data$Salinity, na.rm =TRUE)
} 

Cond_Data

#### Map Functions ####

# Simple example

1:10 #A vector from 1 to 10 (we are going to do this 10 times)

1:10 %>% #A vector from 1 to 10 (we are going to do this 10 times) %>% # the vector to iterate over
  map(rnorm, n = 15) #Calculate 15 random numbers based on a normal distribution in a list

1:10 %>% #A vector from 1 to 10 (we are going to do this 10 times) %>% # the vector to iterate over
  map(rnorm, n = 15)  %>% #Calculate 15 random numbers based on a normal distribution in a list 
  map_dbl(mean) #Calculate the mean. It is now a vector which is type "double"

# Make your own function

1:10 %>% #List 1:10
  map(function(x) rnorm(15, x)) %>% #Make your own function
  map_dbl(mean)

# Use a formula when you want to change the arguments within the function

1:10 %>%
  map(~ rnorm(15, .x)) %>% # changes the arguments inside the function
  map_dbl(mean)

#### Bring in files using <purrr> instead of a for loop ####

# Point to the location on the computer of the folder

CondPath<-here("Week_13", "Data", "cond_data")

files <- dir(path = CondPath,pattern = ".csv")

files

# Save the entire path name

files <- dir(path = CondPath,pattern = ".csv", full.names = TRUE)

files

# Read in the files

data<-files %>%
  set_names()%>% #Sets the id of each list to the file name
  map_df(read_csv,.id = "filename") #Map everything to a data frame and put the id in a column called file name

data

# Calculate means

data<-files %>%
  set_names()%>% #Sets the id of each list to the file name
  map_df(read_csv,.id = "filename") %>% #Map everything to a data frame and put the id in a column called file name
  group_by(filename) %>%
  summarise(mean_temp = mean(Temperature, na.rm = TRUE),
            mean_sal = mean(Salinity,na.rm = TRUE))
data
