### Practice with Tidyr using bio-geochemistry data from Hawaii ####
### Created by: Mikayla Kerchen 
### Updated on: 2023-02-16 

#### Load Libraries ####

library(tidyverse)
library(here)

#### Load data ####

ChemData<-read_csv(here("Week_04","Data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)

#### Data Analysis ####

# Using Separate and Unite #

ChemData_clean <- ChemData %>%    
  filter(complete.cases(.)) %>%   # Filters out everything that is not a complete row (has NAs)
separate(col = Tide_time,   # Filters out everything that is not a complete row
         into = c("Tide", "Time"),   # Separate it into two columns titled Time and Tide
         sep = "_",   # Separate by _
         remove = FALSE) %>%   # Keep the original tide_time column
unite(col = "Site_Zone",  # The name of the NEW column
      c(Site,Zone),    # The columns to unite
      sep = ".",       # Lets put a . in the middle
      remove = FALSE)  # Keep the original Site and Zone columns

View(ChemData_clean)

# Using the Pivot Function #

ChemData_Long <- ChemData %>%
  pivot_longer()

