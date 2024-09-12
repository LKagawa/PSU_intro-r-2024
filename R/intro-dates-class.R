#

# libraries and data ----
library(dplyr)
library(ggplot2)
library(lubridate)
library(plotly)

stations <- read.csv("data/portal_stations.csv", stringsAsFactors = F)
detectors <- read.csv("data/portal_detectors.csv", stringsAsFactors = F)
data <- read.csv("data/agg_data.csv", stringsAsFactors = F)
#  note that the "strings as factors = False" makes xyz

# time ----
str(detectors) # shows data structure
head(detectors$start_date) # shows top 6 entries for specific object cat
# time ##:##:##-07 = offset from UTC by 7hrs vs 8hr offset...#-08

# time zone ----
detectors$start_date <- 
  ymd_hms(detectors$start_date) |> # year-month-day and hr-min-sec
  with_tz("US/Pacific") # assign the time zone or will auto convert to UTC

head(detectors$start_date) # view data samepl; note time offset is now 'PST'

OlsonNames() # lists all of the time zone names

# Examples ----
# EXAMPLE convert detector$end_date to date/time format
detectors$start_date <- 
  ymd_hms(detectors$end_date) |> 
  with_tz("US/Pacific") 

# EXAMPLE find OPEN detectors; without end_date (NA)
open_detectors <- detectors |>
  filter(is.na(end_date)) # filter by NA = end_date

# EXAMPLE find CLOSED detectors; without end_date (NA)
closed_detectors <- detectors |>
  filter(!is.na(end_date)) # filter by NA = end_date

# Join EXAMPLE ----

# EXAMPLE find total daily & avg vol & avg speed/static
# sum volume per lane at each detector
data_stid <- data |>
  left_join(open_detectors, by = c("detector_id" = "detectorid")) |>
  select(
    detector_id, 
    starttime, 
    volume, 
    speed, 
    countreadings, 
    stationid
    )

# convert start time to date time format
data_stid$starttime <- ymd_hms(data_stid$starttime) |>
                                 with_tz("US/Pacific")
# created a summary by month
monthly_data <- data_stid |>
  mutate(month = floor_date(starttime, unit = "month")) # shows 1st of month


# create a summary of daily data
daily_data <- data_stid |>
  mutate(date = floor_date(starttime, unit = "day")) |> # round to nearest unit/day
  group_by(stationid,
           date) |>
    summarize(
      daily_vol = sum(volume),
      daily_obs = sum(countreadings), # sums the daily observation / counts
      mean_speed =  mean(speed)
      ) |>
  as.data.frame() # formats the summarized data as a data frame/tableish

#plot daily data to check
daily_vol_fig <- daily_data |>
  ggplot(aes(x = date, y = daily_vol)) +
  geom_line() +
  geom_point() +
  facet_grid(stationid ~ ., scales = "free")
daily_vol_fig

ggplotly(daily_vol_fig) #nicer plot using PLOTLY library

# 
length(unique(daily_data$stationid))

st_ids <- unique(daily_data$stationid) # create vector of station IDs

start_date <- ymd("2023-03-01") # define start date
end_date <- ymd("2023-03-31") # define end date

df_date <- data.frame(
  date_seq = rep(seq(start_date, end_date, by = "1 day")), # repeat
  station_id = rep(st_ids, each = 31)
)

data_with_gaps <- df_date |>
  left_join(daily_data, by c("date_seq" = "date", 
                             "station_id" = "stationid")
            )

write.csv(data_with_gaps, "data/data_with_gaps.csv", row.names = F)

saveRDS(data_with_gaps, "data/data_with_gaps.rds") # compresses files and maintains structure


