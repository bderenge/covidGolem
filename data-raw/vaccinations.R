## code to prepare `vaccinations` dataset goes here

library(readr)
library(tidyverse)

covid19_vaccinations_in_the_united_states <- read_csv("C:/Users/espor/Downloads/covid19_vaccinations_in_the_united_states.csv")

vaccinations <- covid19_vaccinations_in_the_united_states[,1:49]

vaccinations <- vaccinations %>%
  filter(`State/Territory/Federal Entity` != "American Samoa" & 
           `State/Territory/Federal Entity` != "Bureau of Prisons" & 
           `State/Territory/Federal Entity` != "District of Columbia" & 
           `State/Territory/Federal Entity` != "Dept of Defense" & 
           `State/Territory/Federal Entity` != "Federated States of Micronesia" & 
           `State/Territory/Federal Entity` != "Indian Health Svc" & 
           `State/Territory/Federal Entity` != "Marshall Islands" & 
           `State/Territory/Federal Entity` != "Northern Mariana Islands" & 
           `State/Territory/Federal Entity` != "Puerto Rico" & 
           `State/Territory/Federal Entity` != "Republic of Palau" & 
           `State/Territory/Federal Entity` != "Veterans Health" & 
           `State/Territory/Federal Entity` != "Virgin Islands" & 
           `State/Territory/Federal Entity` != "Guam") 

vaccinations <- vaccinations[,c(1,2,3,5,6,9,10,13,14,21,22,23,24,25,26,27,28)]

vaccinations <- vaccinations %>% 
  rename("State" = `State/Territory/Federal Entity`, 
         "Total Doses Delivered" = `Total Doses Delivered`, 
         "Doses Delivered per 100K" = `Doses Delivered per 100K`,
         "Total Doses Administered" = `Total Doses Administered by State where Administered`,
         "Doses Administered per 100K"= `Doses Administered per 100k by State where Administered`, 
         "People with at least One Dose" = `People with at least One Dose by State of Residence`, 
         "Percent of Pop with at least One Dose" = `Percent of Total Pop with at least One Dose by State of Residence`, 
         "Percent of Pop Fully Vaccinated" = `Percent of Total Pop Fully Vaccinated by State of Residence`, 
         "Total Janssen Doses Administered" = `Total Number of Janssen doses administered`, 
         "Total Moderna Doses Administered" = `Total Number of Moderna doses administered`, 
         "Total Pfizer Doses Administered" = `Total Number of Pfizer doses adminstered`, 
         "Total Other Manufacturer Doses Administered" = `Total Number of doses from Other manufacturer administered`, 
         "People Fully Vaccinated (Moderna)" = `People Fully Vaccinated Moderna Resident`, 
         "People Fully Vaccinated (Pfizer)" = `People Fully Vaccinated Pfizer Resident`, 
         "People Fully Vaccinated (Janssen)" = `People Fully Vaccinated Janssen Resident`, 
         "People Fully Vaccinated (Other)" = `People Fully Vaccinated Other 2-dose manufacturer Resident`
         )

vaccinations[35,1] <- "New York"

population <- state_population[,c(2,4)]

population <- population %>%
  rename("State" = state, 
         "Population" = population)

vaccinations <- full_join(vaccinations, population, by = "State")

vaccinations[1,18] <- 328771307

vaccinations$`Doses Delivered per 100K` <- as.numeric(vaccinations$`Doses Delivered per 100K`)
vaccinations$`Doses Administered per 100K` <- as.numeric(vaccinations$`Doses Administered per 100K`)

vaccinations$`Fully Vaccinated per 100K (Moderna)` = round(vaccinations$`People Fully Vaccinated (Moderna)`/vaccinations$Population * 100000, 2) 
vaccinations$`Fully Vaccinated per 100K (Pfizer)` = round(vaccinations$`People Fully Vaccinated (Pfizer)`/vaccinations$Population * 100000, 2) 
vaccinations$`Fully Vaccinated per 100K (Janssen)` = round(vaccinations$`People Fully Vaccinated (Janssen)`/vaccinations$Population * 100000, 2) 
vaccinations$`Fully Vaccinated per 100K (Other)` = round(vaccinations$`People Fully Vaccinated (Other)`/vaccinations$Population * 100000, 2) 
vaccinations$`Fully Vaccinated per 100K (All Types)` = round(vaccinations$`People Fully Vaccinated by State of Residence`/vaccinations$Population * 100000, 2) 
vaccinations$`At least One Shot per 100K (All Types)` = round(vaccinations$`People with at least One Dose`/vaccinations$Population * 100000, 2)

vaccinations <- vaccinations[-c(52),]


usethis::use_data(vaccinations, overwrite = TRUE)
