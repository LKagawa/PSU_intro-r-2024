# INTRO to XML ####

# libraries & data ####
library(tidyr)
library(dplyr)
library(xml2) # eliminates the need for get/calls
library(readr)

# read in xml data from wsdot stations metadata
meta_xml <- as_list(
            read_xml("https://wsdot.wa.gov/Traffic/WebServices/SWRegion/Service.asmx/GetRTDBLocationData")
            ) # no spaces or paragraphs between web address quotations

View(meta_xml) # shows lists within lists

# Un-nesting ----
meta_df <- as_tibble(meta_xml) |>
  unnest_longer(RTDBLocationList) # widens / unnessts data ; shows a list of lists

meta_unnest_df <- meta_df |>
  filter(RTDBLocationList_id == "RTDBLocation") |>
  unnest_wider(RTDBLocationList)

meta_unnest_more <- meta_unnest_df %>% # for some reason the '|>' isn't working
  unnest(cols = names(.)) %>%
  unnest(cols = names(.)) %>% # action performed twice due to levels
  type_convert()

View(meta_unnest_more)

saveRDS(meta_unnest_more, "data/unnested_wsdot_station_meta.rds")
