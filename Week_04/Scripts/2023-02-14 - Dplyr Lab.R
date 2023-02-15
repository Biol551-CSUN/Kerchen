### Dplyr Lab Work ####
### Created by: Mikayla Kerchen
### Updated on: 2023-02-14

#### Loading Libraries ####
library(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce)
library(ggplot2)

#### Part 1 ####

Penguins_Mean_Var <- penguins %>%      # Uses the penguins data frame and makes a new data frame
  group_by(species, island, sex) %>%   # Groups the data by island, sex, and species
  summarize(mean_body_mass = mean(body_mass_g, na.rm = TRUE),  # Summarizes data by the mean and variance of body mass and excludes NAs
            var_body_mass = var(body_mass_g, na.rm = TRUE))

view(Penguins_Mean_Var)  # Seeing if the data frame shows properly

#### Part 2 ####

Diplyr_plot <- penguins %>%
  filter(sex == "male") %>%   # Filters out females
  mutate(log_body_mass = log(body_mass_g)) %>%    # Adds a column in the data frame for the logarithm of body mass
  select(Species = species, island, sex, log_body_mass) %>%  #selects columns: species, island, sex, log_body_mass
  ggplot(aes(x = Species, 
             y = log_body_mass, 
             fill = Species)) +
  geom_violin(trim = FALSE) +
  geom_boxplot(width = 0.07) +       # Makes a violin plot with box plots inside
  coord_flip() +                     # Flips the coordinate plane
  labs( x = "Species", 
        y = "Log of Body Mass (g)",
        title = "Logarithm of Body Mass in Penguins by Species") +   # Adds titles for the plot and axis
  scale_fill_manual(values = beyonce_palette(101)) +
  theme_bw() +                                        # Uses a black and white theme and uses the Beyonce color palette
  theme(axis.title = element_text(size = 14,
                                  color = "black"),
        plot.title = element_text(size = 15, 
                                  face = "bold", 
                                  hjust = 0.5))   # Changes the size and color of the axis titles. Also changes size and color of title of plot and centers it.

Diplyr_plot

ggsave(here("Week_04", "Output", "DiplyrPlot.png"),
       width = 7, height = 5)
  
  
  

