##This is my first experience plotting!
### Created by: Mikayla Kerchen
### Date:2023-02-07
#################################################

### Load libraries ###
library(tidyverse)
library(palmerpenguins)

### Data Analysis ###
glimpse(penguins) # Shows categories of data within your data frame
head(penguins)   # Looks at the top 6 lines of the data frame
tail(penguins)   # Looks at the bottom 6 lines of the data frame
view(penguins)   # Opens a new window to look at the entire data frame

ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,     # Mapping: Determines the size, shape, alpha, etc. of points based on a variable in the data set.
                     y = bill_length_mm,    # x and y dictate the axis. Color assigns a color to each species in the data frame
                     color = species,       
                     shape = island,        # changes the shape of points based on the island they are from
                     size = body_mass_g,    # size changes the size of points equivalent to the penguins body weight
                     alpha = flipper_length_mm)) + # always add the '+' when adding layers to the graph. 
geom_point() +    # Setting: Determine size, shape, alpha, etc. of points not based on the values of a variable in the data. NO DATA IS A SETTING
  labs(title = "Bill depth and length",     # labs adds a title to the plot
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",     # adds a subtitle under the title
       x = "Bill depth (mm)", y = "Bill length (mm)",    # adds labels for the x and y axis of the plot
       color = "Species",                                #changes the name of the legend
       caption = "Source: Palmer Station LTER / palmerpenguins.package",  # adds a caption to the plot
       shape = "Island",                                                 # changes the name of the legend for island
       alpha = "Flipper length") +                                       # changes the name of the legend for flipper length
       scale_color_viridis_d()

ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                      y = bill_length_mm))+
  geom_point()+
  facet_grid(species~sex)  # splits the plot into different groups by species. can put sex~species to invert the plot

ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm))+
  geom_point()+
  facet_wrap(~species, ncol = 2)  

ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     color = species,
       )) +
  geom_point()+
  scale_color_viridis_d()+
  facet_grid(species~sex)+
  guides(color = FALSE)     # removes the legend for separating the species by color