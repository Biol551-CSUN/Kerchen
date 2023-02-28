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
  mutate(date = mdy_hms(date)) %>%                   # Makes the dates recognizable
  mutate(date = round_date(date, "10 minutes"))      # Rounds the time by 10 minutes and replaces the original date column

datetimesDepth <- DepthData %>%               
  mutate(date = ymd_hms(date))

CompleteData <- inner_join(datetimesCond,datetimesDepth) %>%   # Joins data frames together without NAs
  group_by(date = cut(date, "1 min")) %>%              # Takes averages on depth, salinity, temperature by minute
  mutate(avg_temp = mean(Temperature), 
         avg_salinity = mean(Salinity),
         avg_depth = mean(Depth))

ggplot(data = CompleteData,
         aes(x = avg_temp,                   # Creates a scatter plot of the data frames 
             y = avg_salinity,
             color = avg_depth))+
  geom_point()+
  labs(x = "Average Temperature",
       y = "Average Salinity",
       title = "Average Temperature vs. Average Salinity",
       color = "Average Depth")+               # Colors the plot based on average depth
  theme(axis.title = element_text(size = 14,   # Changes size and titles of the axis and title labels
                                  color = "black"),
        axis.title.x = element_text(vjust = -1),
        axis.title.y = element_text(vjust = 1.5),    # Adjusts the axis title away from the tick labels
        plot.title = element_text(size = 15, 
                                  face = "bold", 
                                  hjust = 0.5),
        axis.text = element_text(size = 9,
                                 color = "black"),
        legend.position = "bottom", legend.box = "horizontal", legend.justification = "center")  # Moves the legend to the bottom, makes it horizontal, and centers it.
  
ggsave(here("Week_05", "Output", "LubridatePlot.png"),         # Saves the plot to the output folder and changes the size of the image
       width = 7, height = 7)
