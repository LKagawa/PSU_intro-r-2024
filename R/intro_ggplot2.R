# libraries & data ----
library(dplyr)   # functions
library(ggplot2) # graphing
library(readxl)  # excel

df_ice <- read_xlsx("data/icebreaker_answers.xlsx") # data

# plotting ----
tt_mi_fig <- df_ice |> # Figure of travel time in Miles
  ggplot(
    aes(x = travel_time, # aesthetics: x & y definitions
        y = travel_distance)
        ) + # '+' adds a layer to th plot thus far
    geom_point()# geometry points

tt_mi_fig # displays the figure

# with color & relabled axsis
tt_mi_ox_fig <- df_ice |>
  ggplot(
    aes(x = travel_time,
        y = travel_distance,
        color = serial_comma)
   ) +
  geom_point() +
  xlab("Travel Time") +
  ylab("Travel Distance")

tt_mi_ox_fig

# changed background/theme of figure
tt_mi_fig <- tt_mi_fig +
  theme_bw()

tt_mi_fig

# create figure using mode instead of serial_comma
tt_mi_mode_fig <- df_ice |>
  ggplot(
    aes(x = travel_time,
        y = travel_distance,
        color = travel_mode))+
  geom_point() +
  xlab("Travel Time") +
  ylab("Travel Distance")

tt_mi_mode_fig

# faceting ----
ice_facet_fig <- df_ice |>
  ggplot(aes(x = travel_time,
             y = travel_distance))+
  geom_point() +
  facet_wrap(. ~ travel_mode) # facet Wrap


ice_facet_fig <- df_ice |>
  ggplot(aes(x = travel_time,
             y = travel_distance))+
  geom_point() +
  facet_grid(. ~ travel_mode) # facet grid


ice_facet_fig <- df_ice |>
  ggplot(aes(x = travel_time,
             y = travel_distance))+
  geom_point() +
  facet_grid(. ~ travel_mode ~ ., # GRID
             scale = "free") # adds scale to "facet"


ice_facet_fig <- df_ice |>
  ggplot(aes(x = travel_time,
             y = travel_distance))+
  geom_point() +
  facet_wrap(. ~ travel_mode ~ ., # WRAP
             scale = "free") # adds scale to "facet"


ice_facet_fig

# pre-processing / filtering with figures ----
tt_mode_car_fig <- df_ice |>
  filter(travel_mode == "car") |>
  ggplot(aes(x = travel_time,
             y = travel_distance)) +
  geom_point() +
  theme_bw()

tt_mode_car_fig
