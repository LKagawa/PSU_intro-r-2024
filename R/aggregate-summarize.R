#### Aggregating and Summarizing Data ####

# library and data ----
library(readxl)
library(dplyr)
library(ggplot2)

df_icebreakers <- read_excel("data/icebreaker_answers.xlsx")
View(df_icebreakers)


# customize summaries of a data ---- 
# object type is shown by 'viewing' the data. See line 19
# View() the data may show more precision
df_summary_ice <- df_icebreakers |> summarize(
  avg_dist = mean(travel_distance),
  sd_dist = sd(travel_distance), # standard deviation
  pct60_dist = quantile(travel_distance, prob = 0.6), # 60th percentile
  median_mode = median(travel_mode)
) 
# type: df_summary_ice

# convert default numeric to integer
df_icebreakers_int <- df_icebreakers |> 
  mutate(travel_time = as.integer(travel_time) # converts travel time to integer
)


# agg & sum subsets ----
df_icebreakers <- df_icebreakers |>
  mutate(travel_speed = travel_distance / travel_time * 60)

df_icebreakers |>
  summarize(avg_speed = mean(travel_speed))

df_icebreakers |> group_by(travel_mode) |>
  summarize(average_speed = mean(travel_speed)) |> # summarized avg speed by mode
  arrange(desc(average_speed)) # arranges the avg speed in descending order


# grouped data ----
df_icebreakers |> group_by(travel_mode) # shows a tibble # x # & how is grouped

df_grp_ice_mode <- df_icebreakers |> group_by(travel_mode) # creates a sep. group
str(df_grp_ice_mode) # shows group structure

# by default, summarize will leave data grouped by next higher level
# higher level is in order of group; example below is 'travel_mode'
df_icebreakers |> 
  group_by(travel_mode, serial_comma) |> # groups by multiple criteria
  summarize(average_speed = mean(travel_speed))


# UNGROUP
df_ungrp_ice_mode <- df_icebreakers |> 
  group_by(travel_mode) |>
  summarize(average_speed = mean(travel_speed)) |>
  ungroup() # ungroups so that future summarizations are not grouped


# frequency analysis ----

df_icebreakers |>
  group_by(serial_comma) |>
  summarize("count" = n()) # returns count as integer

df_icebreakers |>
  group_by(serial_comma) |>
  tally() 

df_icebreakers |> 
  count(serial_comma)

df_icebreakers |>
  count(serial_comma, sort = T)


# CALCULATE a mode split from icebreaker (% using each mode)
df_icebreakers |> count(travel_mode)

df_icebreakers |>
  group_by(travel_mode) |>
  summarize(split = n() / nrow(df_icebreakers) * 100) |>
  arrange(desc(split))
             
             