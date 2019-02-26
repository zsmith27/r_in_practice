# Global
# Load Packages -----------------------------------------------------------

library(shiny)
library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
library(leaflet)

# Import Data -------------------------------------------------------------

taxa.df <- file.path(#"shiny","thesis",
                     "data",
                     "zms_thesis-macro_2017-06-18.csv") %>% 
  read.csv(stringsAsFactors = FALSE)

# Functions ---------------------------------------------------------------

pct <- function(value, total) {
  value / total * 100
}

# Prep --------------------------------------------------------------------

prep.df <- taxa.df %>% 
  mutate(lake = case_when(
    lake == "onon" ~ "Onondaga",
    lake == "ot" ~ "Otisco",
    lake == "caz" ~ "Cazenovia",
    TRUE ~ "ERROR"
  )) %>% 
  group_by(unique_id) %>% 
  mutate(total = sum(count)) %>% 
  ungroup() %>% 
  mutate(percent = pct(count, total)) %>% 
  select(unique_id, lake, station_id, sample_number,
         lat, long, date,
         order, family, genus, final_id, percent) %>% 
  gather(rank, taxon, c(final_id, order:genus))

