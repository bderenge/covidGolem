# Building a Prod-Ready, Robust Shiny Application.
# 
# README: each step of the dev files is optional, and you don't have to 
# fill every dev scripts before getting started. 
# 01_start.R should be filled at start. 
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
# 
# 
###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

# Engineering

## Dependencies ----
## Add one line by package you want to add as dependency
usethis::use_package( "thinkr" ) 
usethis::use_package( "ggplot2" )
usethis::use_package( "dplyr" )
usethis::use_package( "lubridate" )
usethis::use_package( "car" )
usethis::use_package( "plotly" )
usethis::use_package( "RSelenium" )
usethis::use_package( "shiny" )
usethis::use_package( "golem" )
usethis::use_package( "tidyr" )
usethis::use_package( "purrr" )
usethis::use_package( "imputeTS" )

## Add modules ----
## Create a module infrastructure in R/
golem::add_module( name = "united_states" ) # Name of the module
golem::add_module( name = "states" )
golem::add_module( name = "counties" )
golem::add_module( name = "methodology" )# Name of the module
golem::add_module( name = "vaccinations" )



golem::add_fct( "get_data" ) 
golem::add_fct( "maps" ) 
golem::add_fct( "time_series_plots" )
golem::add_fct( "sir_plots" )

## Add helper functions ----
## Creates fct_* and utils_*
golem::add_fct( "helpers" ) 
golem::add_utils( "helpers" )

## External resources
## Creates .js and .css files at inst/app/www
golem::add_js_file( "script" )
golem::add_js_handler( "handlers" )
golem::add_css_file( "custom" )

## Add internal datasets ----
## If you have data in your package
usethis::use_data_raw( name = "county_population", open = FALSE ) 
usethis::use_data_raw( name = "state_population", open = FALSE ) 
usethis::use_data_raw( name = "us_population", open = FALSE ) 
usethis::use_data_raw( name = "temp_states", open = FALSE )
usethis::use_data_raw( name = "temp_county", open = FALSE )
usethis::use_data_raw( name = "vaccinations", open = FALSE)

## Tests ----
## Add one line by test you want to create
usethis::use_test( "app" )

# Documentation

## Vignette ----
usethis::use_vignette("covidGolem")
devtools::build_vignettes()

## Code Coverage----
## Set the code coverage service ("codecov" or "coveralls")
usethis::use_coverage()

# Create a summary readme for the testthat subdirectory
covrpage::covrpage()

## CI ----
## Use this part of the script if you need to set up a CI
## service for your application
## 
## (You'll need GitHub there)
usethis::use_github()

# GitHub Actions
usethis::use_github_action() 
# Chose one of the three
# See https://usethis.r-lib.org/reference/use_github_action.html
usethis::use_github_action_check_release() 
usethis::use_github_action_check_standard() 
usethis::use_github_action_check_full() 
# Add action for PR
usethis::use_github_action_pr_commands()

# Travis CI
usethis::use_travis() 
usethis::use_travis_badge() 

# AppVeyor 
usethis::use_appveyor() 
usethis::use_appveyor_badge()

# Circle CI
usethis::use_circleci()
usethis::use_circleci_badge()

# Jenkins
usethis::use_jenkins()

# GitLab CI
usethis::use_gitlab_ci()

# You're now set! ----
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")

