#!/usr/bin/env R

library(shiny)
library(tidyverse)
library(lubridate)
library(leaflet)

load("data.RData")

theme_set(theme_classic(base_size = 15))
current_site_color <- "#023047"
elevatioon_group_colors <- c(Berg = "#283618", Tal = "#b5838d")
