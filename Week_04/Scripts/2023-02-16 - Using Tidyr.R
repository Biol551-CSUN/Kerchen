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

ChemData_Long <- ChemData_clean %>%
  pivot_longer(cols = Temp_in:percent_sgd,  # The columns you want to pivot. This says select the Temp to the percent SGD columns
               names_to = "Variables",    # The names of the new columns with all the column names
               values_to = "Values")     # Names of the new column with all the values

View(ChemData_Long)

# Calculating Mean and Variance for the Variable at Each Site #

ChemData_Long %>%
  group_by(Variables, Site) %>%  # Group by everything we want
  summarize(Param_means = mean(Values, na.rm = TRUE),  # Get the mean
            Param_vars = var(Values, na.rm = TRUE))   # Get the variance

#Calculate Mean, Variance, and Standard Deviation for Variables by Site, Zone, and Tide #

ChemData_Long %>%
  group_by(Variables, Site, Zone, Tide) %>%
  summarize(Param_means = mean(Values, na.rm = TRUE),
            Param_vars = var(Values, na.rm = TRUE),
            Param_sd = sd(Values, na.rm = TRUE))

# Create Box plots of Every Parameter on Site #

ChemData_Long %>%
  ggplot(aes(x = Site, y = Values))+
  geom_boxplot()+
  facet_wrap(~Variables, scales = "free")

# Converting Back to Wide Data #

ChemData_Wide <- ChemData_Long %>%
  pivot_wider(names_from = Variables,   # Column with the names for the new columns
              values_from = Values)    # Column with the values

# Calculate Summary Statistics and Export csv File #

ChemData_clean <- ChemData %>%
  drop_na() %>%
  separate(col = Tide_time,
           into = c("Tide","Time"),
           sep = "_",
           remove = FALSE) %>%
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values") %>%
  group_by(Variables, Site, Time) %>%
  summarize(mean_vals = mean(Values, na.rm = TRUE)) %>%
  pivot_wider(names_from = Variables,
              values_from = mean_vals) %>%
  write_csv(here("Week_04", "Output", "Chem_Summary.csv"))

View(ChemData_clean)
