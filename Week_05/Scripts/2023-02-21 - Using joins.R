#### Using joins ######
### Created by: Mikayla Kerchen
### Updated on: 2023-02-21
########################################

#### Load Libraries ####
library(tidyverse)
library(here)

#### Load Data ####

# Environmental data from each site
EnviroData <- read_csv(here("Week_05","Data","site.characteristics.data.csv"))

# Thermal performance data
TPCData <- read_csv(here("Week_05", "Data", "Topt_data.csv"))

glimpse(EnviroData)
glimpse(TPCData)
view(EnviroData)
view(TPCData)

#### Data Analysis ####

EnviroData_wide <-  EnviroData %>%
  pivot_wider(names_from = parameter.measured,  #pivot the data wider
              values_from = values) %>%      
  arrange(site.letter)    # Arranges the data in alphabetical order for the site numbers

view(EnviroData_wide)

FullData_left <- left_join(TPCData, EnviroData_wide) %>%
  relocate(where(is.numeric), .after = where(is.character)) #relocate all the numeric data on the left and the character data on the right

head(FullData_left)

# Ways to get mean and variance for all values in the data set

ThinkData <- FullData_left %>%
  pivot_longer(cols = E:substrate.cover,
               names_to = "Variables",
               values_to = "Values") %>%
  summarize(mean_vals = mean(Values, na.rm = TRUE),
            var_vals = var(Values, na.rm = TRUE))

View(ThinkData)

FullData_left %>%
  group_by(site.letter) %>%
  summarize_at(vars(E:substrate.cover), funs(mean = mean,var = var))

View(FullData_left)

# Creating your own tibble

# Make one tibble
T1 <- tibble(Site.ID = c("A","B","C","D"),
             temperature = c(14.1, 16.7, 15.3, 12.8))

# Make another tibble
T2 <- tibble(Site.ID = c("A","B","D","E"),
             pH = c(7.3, 7.8, 8.1, 7.9))

T1
T2

# Using the tibbles with the different join functions

left_join(T1,T2)  # joins T2 to T1. Drops E site since there was no E site in T1
right_join(T1,T2) # joins T1 to T2. Drops C site since there was no C site in T2

inner_join(T1,T2) # Only keeps data that is complete in both data sets

full_join(T1,T2) # Keeps everything in both data sets

semi_join(T1,T2) # Only keeps the columns that are the same in both data sets

anti_join(T1,T2) #Only keeps the columns that are missing from both data sets
