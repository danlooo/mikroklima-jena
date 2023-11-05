library(tidyverse)
library(lubridate)

sites <-
  read_csv("data/sites.csv") |>
  mutate(
    Latitude_WGS84_N = round(Latitude_WGS84_N, 3),
    Longitude_WGS84_E = round(Longitude_WGS84_E, 3)
  )

load("data/15_data.all.2022.RData")
observations <- data.all

temp_stats <-
  observations |>
  mutate(date = floor_date(date.time, "day")) |>
  group_by(WZE_ID, date) |>
  summarise(
    min_temp = min(T.air_150_cm),
    max_temp = max(T.air_150_cm),
    temp_span = max_temp - min_temp
  ) |>
  left_join(sites) |>
  # mutate(elevation_group = cut(elevation, seq(min(elevation), max(elevation), 5)))
  mutate(elevation_group = case_when(
    elevation > 320 ~ "Berg",
    TRUE ~ "Tal"
  ))

temp_stats_groups <-
  temp_stats |>
  group_by(date, elevation_group) |>
  summarise(temp_span = mean(temp_span, na.rm = TRUE))

save.image("data/data.RData")
