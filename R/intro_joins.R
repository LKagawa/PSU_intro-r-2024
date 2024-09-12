# libraries and data ----
library(dplyr)
library(ggplot2)

detectors <- read.csv("data/portal_detectors.csv", 
                      stringsAsFactors = F)
stations <- read.csv("data/portal_stations.csv", 
                     stringsAsFactors = F)
data <- read.csv("data/agg_data.csv", 
                 stringsAsFactors = F)

table(data$detector_id) # displays type of info in a data set

data_detectors <- data |>
  distinct(detector_id)

# relating different data sets (joining) ----
data_detectors_meta <- data_detectors |>
  left_join(detectors, by = c("detector_id" = "detectorid")) # identifying all detectors per ID

data_detectors_missing <- detectors |>
  anti_join(data_detectors, by = c("detectorid" = "detector_id")) |> # identifying missing records
  distinct(detectorid) 

