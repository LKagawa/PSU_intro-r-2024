#### Practice Problem: Loading and manipulating a data frame ####
# Don't forget: Comment anywhere the code isn't obvious to you!

# Load the readxl and dplyr packages
library(readxl)
library(dplyr)

# Use the read_excel function to load the class survey data
survey_results <- read_excel("data/icebreaker_answers.xlsx")

# Take a peek!
View(survey_results)

# Create a travel_speed column in your data frame using vector operations and 
#   assignment
survey_results$travel_mph <- (
  survey_results$travel_distance / 
  (survey_results$travel_time / 60) # MPH
  )

# Look at a summary of the new variable--seem reasonable?
summary(survey_results)
boxplot(survey_results$travel_mph ~ survey_results$travel_mode)

# Choose a travel mode, and use a pipe to filter the data by your travels
results_bike <- survey_results |>
  filter(
    travel_mode == "bike"
  )
summary(results_bike)

results_car <- survey_results |>
  filter(
    travel_mode == "car"
  )
summary(results_car)

# Note the frequency of the mode (# of rows returned)

# Repeat the above, but this time assign the result to a new data frame

# Look at a summary of the speed variable for just your travel mode--seem 
#   reasonable?

# Filter the data by some arbitrary time, distance, or speed threshold
survey_results |> 
  filter(
    travel_mph > 20 & travel_mph < 50
    )
# Stretch yourself: Repeat the above, but this time filter the data by two 
#   travel modes (Hint: %in%)
survey_results |> 
