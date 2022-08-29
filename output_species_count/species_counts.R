#to do some stuff
## Author: Your name here
## Date: 2022-08-29

## The aim of this script is to produce a table of species observation counts, and a bar plot
## showing the species counts for the most diverse genera in the survey



# Load libraries (make sure they are installed first!)

if (!('tidyverse' %in% row.names(installed.packages()))) install.packages('tidyverse', dependencies = TRUE)

library(tidyverse)



# Get the data (or load into R directly from the web)

#surveys <- read_csv("https://ndownloader.figshare.com/files/2292169")

surveys <- read_csv("data/survey_sample.csv")



# Have a look at the structure of the data

str(surveys)



# Count number of observations of each species

species_counts <- surveys %>%
  
  group_by(genus, species, species_id) %>%
  
  count() %>%
  
  arrange(genus, species)



# In the species present, count representative species of each genus

genus_counts <- species_counts %>%
  
  group_by(genus) %>%
  
  count(sort = TRUE)



# Identify top 3 most diverse genera

most_diverse <- genus_counts$genus[c(1,2,3)]



# Get counts of species in the 3 most-diverse genera

diverse_genus <- species_counts %>%
  
  filter(genus %in% most_diverse) %>%
  
  arrange(desc(n))


# Save the table to file

write_csv(diverse_genus, 'output_species_count/species_counts_table.csv')


# Plot counts of observations for 3 most-diverse genera

ggplot(data = diverse_genus, mapping = aes(x = species_id, y = n, fill = genus)) +
  
  geom_bar(stat = 'identity')


ggsave('output_species_count/species_counts_barplot.png')




