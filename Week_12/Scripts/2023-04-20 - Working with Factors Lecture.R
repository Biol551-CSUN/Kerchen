#### Working with Factors Lecture ####
#### Created by: Mikayla Kerchen
#### Updated on: 2023-04-20
#########################################3

#### Load Libraries ####

library(tidyverse)
library(here)

#### Load Data ####

income_mean <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_mean.csv')


#### What is a factor? ####

fruits<-factor(c("Apple", "Grape", "Banana"))

fruits  # Default levels are always alphabetical

#### Factor Booby-Traps ####

test<-c("A", "1", "2")

as.numeric(test)

test<-factor(test) # Convert to factor

as.numeric(test) # Converts the NA to a 3

#### {forcats} ####

glimpse(starwars)

#### starwars ####

starwars %>% 
  filter(!is.na(species)) %>% # Remove the NAs
  count(species, sort = TRUE)  # Gives a sorted list of species in starwars

star_counts<-starwars %>%
  filter(!is.na(species)) %>%
  mutate(species = fct_lump(species, n = 3)) %>%
  count(species)

star_counts   # The species are now in aloahbetical order since it is now a factor

#### Reordering Factors ####

## Basic plot ##

star_counts %>%
  ggplot(aes(x = species, y = n))+
  geom_col()

## Ordered plot ##

star_counts %>%
  ggplot(aes(x = fct_reorder(species, n), y = n))+ # Reorder the factor of species by n
  geom_col()

## Descending order plot ##

star_counts %>%
  ggplot(aes(x = fct_reorder(species, n, .desc = TRUE), y = n))+ # Reorder the factor of species by n and makes the plot go in decending order
  geom_col() +
  labs(x = "Species")

#### Reordering Line Plots ####

glimpse(income_mean)

total_income<-income_mean %>%
  group_by(year, income_quintile)%>%
  summarise(income_dollars_sum = sum(income_dollars))%>%
  mutate(income_quintile = factor(income_quintile)) # make it a factor

## Basic line plot ##

total_income%>%
  ggplot(aes(x = year, y = income_dollars_sum, color = income_quintile))+
  geom_line()

## Reordering the line plot ##

total_income%>%
  ggplot(aes(x = year, y = income_dollars_sum, 
             color = fct_reorder2(income_quintile,year,income_dollars_sum)))+  #fct_reorder2 is only for line plots
  geom_line()+
  labs(color = "income quantile")

#### Reorder Levels Directly in a Vector ####

x1 <- factor(c("Jan", "Mar", "Apr", "Dec"))

x1

## Specifying the order of levels ##

x1 <- factor(c("Jan", "Mar", "Apr", "Dec"), levels = c("Jan", "Mar", "Apr", "Dec"))

x1

#### Subset Data with Factors ####

starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # Remove the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # Make species a factor
  filter(n>3) # Only keep species that have more than 3

starwars_clean

## Check the levels of the factor ##

levels(starwars_clean$species)

## Remove extra levels ##

starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # Remove the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # Make species a factor 
  filter(n>3)  %>% # Only keep species that have more than 3 
  droplevels() # Drop extra levels

levels(starwars_clean$species)

#### Recode Levels ####

starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # Remove the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # Make species a factor 
  filter(n>3)  %>% # Only keep species that have more than 3 
  droplevels() %>% # Drop extra levels 
  mutate(species = fct_recode(species, "Humanoid" = "Human"))

starwars_clean
