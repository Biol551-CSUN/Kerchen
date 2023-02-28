#### Lubridate Lab ####
### Created by: Mikayla Kerchen
### Updated on:2023-02-23
#######################################

#### Load Libraries ####

library(tidyverse)
library(here)
library(lubridate)

#### Load Data ####

CondData <- read.csv(here("Week_05","Data","CondData.csv"))

DepthData <- read.csv(here("Week_05","Data","DepthData.csv"))

View(CondData)

View (DepthData)

#### Data Analysis and Plotting ####

datetimesCond <- CondData %>%
  mutate(date = ymd_hm(date)) 

datetimesDepth <- DepthData %>%
  mutate(date = ymd_hm(date))
