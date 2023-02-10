##### Graph of Penguin Data #####
### Created by: Mikayla Kerchen
### Date: 2023-02-09  

####################################

#### Loading Libraries ####
library(ggplot2)
library(palmerpenguins)
library (here)
library(beyonce)

#### Load Data ####
view(penguins)
summary(penguins)

#### Data Analysis ####

ggplot(data=penguins,
       mapping = aes(x = body_mass_g, fill = island)) +     # Only uses one axis. Fill separates it by island.
geom_histogram(col=I("black")) +   # Adds an outline to the columns
labs(x = "Body mass (g)",
     y = "Count",
     fill = "Island",
     title = "Body Mass in Penguins Grouped by Island") +
theme_bw() +
theme(axis.title = element_text(size=14,
                                color = "black"),
      panel.grid = element_line(color = "lightgrey"),
      panel.background = element_rect(fill = "beige"),
      legend.key = element_rect(color = "beige"),
      plot.title = element_text(size = 15, face = "bold", hjust = 0.5)) +  # Bold the title, changes the size, and centers the title
scale_fill_brewer(palette = "Accent")

ggsave(here("Week_03", "Output", "Body Mass by Island.png"),
       width = 7, height = 5)
