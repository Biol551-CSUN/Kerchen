#### Tidyr Lab ####
### Created by: Mikayla Kerchen
### Updated on: 2023-02-16
########################################

#### Load Libraries ####

library(tidyverse)
library(here)

#### Load in Data ####

ChemData <- read.csv(here("Week_04", "Data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)

#### Data Analysis and Plotting ####

ChemData_clean <- ChemData %>%
  drop_na() %>%                 # Drops the NAs in the data set
  separate(col = Tide_time,     # Separates the Tide and Time columns
           into = c("Tide", "Time"),
           sep = "_",
           remove = FALSE) %>%
  filter(Time == "Day") %>%     # Filtering out the data during the day
  pivot_longer(cols = Temp_in:percent_sgd,  # Selects the Temp to the percent SGD columns
                names_to = "Variables",    # The names of the new columns with all the column names
                values_to = "Values")%>%
  group_by(Variables, Site, Zone, Time) %>%  # Groups the data by variables, site, zone and time
  summarize(Param_mean = mean(Values, na.rm = TRUE),  # Calculates the mean
            Param_std = sd(Values, na.rm = TRUE)) %>% # Calculates the standard deviation
  write_csv(here("Week_04", "Output","Chem_Summary_Lab.csv")) #Exports the csv file

View(ChemData_clean)

ChemData_clean %>%
  ggplot(aes(x = Param_mean, fill = Zone))+
  geom_histogram(col=I("black"))+             # Creates a histogram graph and outlines the columns in black
  labs(x = "Zone",                            # Labels the axis titles and plot title
       y = "Mean of Chemical Parameters",
       title = "Mean of Chemical Variables According to Zone")+
  facet_wrap(~Variables, scales = "free")+    # facet wraps the plot based on the different variables
  theme_light()+
  theme(axis.title = element_text(size = 14,   # Changes size and titles of the axis and title labels
                                  color = "black"),
        axis.title.x = element_text(vjust = -1),
        axis.title.y = element_text(vjust = 1.5),    # Adjusts the axis title away from the tick labels
        plot.title = element_text(size = 15, 
                                  face = "bold", 
                                  hjust = 0.5),
        axis.text = element_text(size = 9,
                                 color = "black"))+
  scale_fill_viridis_d()                             # Adds colorblind friendly color scale

ggsave(here("Week_04", "Output", "TidyrPlot.png"),
             width = 10, height = 10)
