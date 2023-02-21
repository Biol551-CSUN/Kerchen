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
