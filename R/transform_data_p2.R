# libraries ----
library(readxl)
library(dplyr)

df_icebreaker <- read_excel("data/icebreaker_answers.xlsx")
df_icebreaker # shows first 10 entries

# data frame stuff ----

df_icebreaker <- df_icebreaker |>
  bind_rows( # adds a row to the data set
    slice_tail(df_icebreaker) # uses the last existing row of data
  )
View(df_icebreaker)

df_icebreaker <- df_icebreaker |>
  distinct() # returns only 1 unique row per set of value 

View(df_icebreaker)

df_icebreaker %>% select( # grabs specified columns (%>% = pipe)
  travel_mode, 
  travel_distance, 
  travel_time
  ) 

df_icebreaker |> select(-serial_comma) # excludes specific column

df_icebreaker |> select(travel_mode : travel_time) # columns between specified

df_icebreaker |> select( # select by expression
  starts_with("travel_")
)

df_travel <- df_icebreaker |>
  select(-serial_comma)

# mutate & rename ----
# mutate and rename (creating and modifying data frames)
df_travel$travel_speed <- (df_travel$travel_distance / 
                             df_travel$travel_time * 60)
df_travel <- df_travel |>
  mutate(travel_speed = travel_distance / travel_time * 60)
summary(df_travel)

# Logic ----
# If/Else
df_travel <- df_travel |>
  mutate(long_trip =
           if_else(travel_distance > 20, # distance greater than 20 miles
                   1, 0) # assigns True=1 or False=0
         )

# case when
df_travel <- df_travel |>
  mutate(short_trip =
           case_when(
             travel_mode == "bike" & mph < 12 ~ 1,
             travel_mode == "car"  & mph < 25 ~ 1,
             travel_mode == "bus" & mph < 15 ~ 1,
             travel_mode == "light rail" & mph < 20 ~ 1,
             .default = 0 # all false or NA values will be 0
           )
        )

  
View(df_travel)

# rename columns ----
df_travel <- df_travel |>
  rename(mph = travel_speed) # renames travel speed column to mph

colnames(df_travel) # prints column names

# arrange data ----
df_travel |> 
  arrange(mph
  )

df_travel |>
  arrange(mph)|> 
  print(n=15) # shows specific number of rows

df_travel |>
  arrange(travel_mode, mph) |> # arranges by mode and ascending speed
            print(n=7)

df_travel |>
  arrange(desc(mph)) # arrange by descending

boxplot(df_travel$mph ~df_travel$long_trip)
