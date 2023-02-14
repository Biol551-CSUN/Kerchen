### Today we are going to plot penguin data ###
### Created by: Mikayla Kerchen
### Updated on: 2023-02-14

#### Load Libraries ####
library(palmerpenguins)
library(tidyverse)
library(here)

#### Load Data ####
glimpse(penguins)
head(penguins)

#### Filtering Data ####

# Filtering Penguins by sex #
filter(.data = penguins, 
       sex == "female") # Two equal signs means "exactly equal to". So in this data set we want sex exactly equal to female.

# Filtering Penguins by sex and weight #
filter(.data = penguins, 
       sex == "female", body_mass_g > 5000) # filters for females that weight over 5000g
filter(.data = penguins, 
       sex == "female" & body_mass_g > 5000) # does the same thing as the line above

# Filter Penguins in the year 2008 and 2009 #
filter(.data = penguins, 
       year == "2008" | year == "2009") # Can also use year %in% c("2008","2009"). Finds penguins from the years 2008 and 2009.

# Filter Penguins not from the island Dream #
filter(.data = penguins, 
       island != "Dream") # Shows penguins not from the island Dream

# Filter Penguins from the species Adelie and Gentoo #
filter(.data = penguins, 
       species == "Adelie" | species == "Gentoo") # Shows penguins that are the species Adelie and Gentoo. Can also use %in% c("Adelie", "Gentoo")

#### Mutating penguin data ####

# Using mutate to covert body mass to kg and calculate the ratio of flipper length to body mass #
data2 <- mutate(.data = penguins, 
                body_mass_kg = body_mass_g/1000, # Converts mass to kg
                bill_length_depth = bill_length_mm/bill_depth_mm) # Calculate the ratio of bill length to depth.
                        
view(data2)

# Mutate with ifelse #
data2 <-mutate(.data = penguins, 
               after_2008 = ifelse(year>2008, "After 2008", "Before 2008")) # Adds a column to the data to list if the penguin was founf before 2008 or after 2008

view(data2)

# Using mutate to combine body mass and flipper length together #
data2 <- mutate(.data = penguins, 
                flipper_length_body_mass = flipper_length_mm + body_mass_g) # Adds a column to the data that combines the values of flipper length and body mass together.

view(data2)

# Using mutate and ifelse for body mass > 4000 to be listed as big  and body mass < 4000 as small #
data2 <- mutate(.data = penguins, 
                greater_4000=ifelse(body_mass_g > 4000, "Big", "Small")) # Adds a column to the data where penguins larger than 4000g are big and lesser than 4000g are small

view(data2)

#### Using the Pipe (%>%) ####

penguins %>% # Use penguin data frame
  filter(sex == "female") %>% # select females
  mutate(log_mass = log(body_mass_g)) %>% # calculate log biomass
  select(Species = species, island, sex, log_mass) 

#### Summarizing Data ####

penguins %>%
  summarize(mean_flipper = mean(flipper_length_mm, na.rm = TRUE), # Calculates the mean flipper length and removes the NAs so R can actually calculate a mean
            min_flipper = min(flipper_length_mm, na.rm = TRUE)) # Calculates the min of the flipper length

# Group by island #

penguins %>%
  group_by(island) %>%
  summarize(mean_flipper = mean(bill_length_mm, na.rm = TRUE), # Calculates the mean bill length and removes the NAs so R can actually calculate a mean
            max_flipper = max(bill_length_mm, na.rm = TRUE))

# Group by island and sex #

penguins %>%
  group_by(island, sex) %>%
  summarize(mean_flipper = mean(bill_length_mm, na.rm = TRUE), 
            max_flipper = max(bill_length_mm, na.rm = TRUE))

#### Remove NAs ####

penguins %>%
  drop_na(sex) # Drop all the rows that are missing the data on sex. 

# Drop rows missing data on sex and calculates mean bill length by sex #

penguins %>%
  drop_na(sex) %>% 
  group_by(island, sex) %>%
  summarize(mean_bill_length = mean(bill_length_mm,na.rm = TRUE))

#### Pipe into a ggplot ####

penguins %>%
  drop_na(sex) %>%
  ggplot(aes(x = sex, y = flipper_length_mm)) +
  geom_boxplot()
