## This is my first script! Learning how to import data
### Created by: Mikayla Kerchen
### Created on: 2023-02-02
#################################################

### Load libraries ###########
library(tidyverse)
library(here)

### Read in data ###
WeightData<-read_csv(here("Week_02","Data","weightdata.csv"))

###Data Analysis ###
head(WeightData)  # Looks at the top 6 lines of the data frame
tail(WeightData)  # Looks at the bottom 6 of the data frame
view(WeightData)  # Opens a new window to look at the entire data frame
glimpse(WeightData)  # Shows categories of data within your data frame


