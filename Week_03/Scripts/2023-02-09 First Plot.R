##### Making my First Plot #####
### Created by: Mikayla Kerchen
### Date: 2023-02-09

#####################################

#### Loading Libraries ####
library(beyonce)
library(palmerpenguins)
library(tidyverse)
library(here)

#### Data Analysis ####
glimpse(penguins)


plot1 <- ggplot(data = penguins,
  mapping = aes(x = bill_depth_mm,
                y = bill_length_mm,
                group = species,
                color = species))+
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Bill depth (mm)",
       y = "Bill length (mm)")+
#scale_color_viridis_d()+
scale_color_manual(values = beyonce_palette(5))+
  theme_bw()+
  theme(axis.title = element_text(size = 20))+
  theme(panel.background = element_rect(fill = NA),
        panel.grid.major = element_line(color = "grey50"),
        panel.ontop = TRUE)
plot1

ggsave(here("Week_03","Output","penguin_graph.png"),
       width = 7, height = 5)
                     

