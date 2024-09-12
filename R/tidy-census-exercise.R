##

# libraries & data ----
library(dplyr)
library(tidyr)
library(ggplot2)
library(tidycensus) # for ACS & decennial census data via API;
                    # for more info see: walker-data.com/tidycensus/

census_api_key( # run this code if key not already stored in R
  "9a8503e2c3f02690d100a8f53a012e52cb5008c2", # see email for alphanumeric key from Census
  install = TRUE) # installs into R for future use in '.Renvion'

readRenviron("~/.Renviron")

# user functions ####
### FUNCTION TIDY_ACS ####
# takes tidycensus acs results and returns a wide and tidy table 
tidy_acs_results <- function( 
    raw_results, # required value
    include_moe = FALSE) { # default value & begins function
      if(isTRUE(include_moe)) {
        df_new <- raw_results |>
          pivot_wider(id_cols = GEOID:NAME,
                     names_from = variable,
                     values_from =  estimate:moe
                     )
      } else {
        df_new <- raw_results |>
          pivot_wider(id_cols = GEOID:NAME,
                     names_from = variable,
                     values_from =  estimate
                    )
      }
      return(df_new)
    } 

# get a searchable census variable table ----
v19 <- load_variables(2019, "acs5") # acs = american community survey; 5 year

v19 |>
  filter(
    grepl("^B08006_", name)) |>
  print(n = 25)

# get data for transit, wfh, and total workers ####
### 2019 data ----
comm_19_raw <- get_acs( # use '?get_acs' to find out more about the function
                geography = "tract",
                variables = c(
                            wfh = "B08006_017",
                            transit = "B08006_008",
                            tot = "B08006_001"),
                county = "Multnomah",
                state = "OR",
                year = 2019, # is end year; 2015-2019
                survey = "acs5",
                geometry = FALSE # can retrieve library (sf) spatial geoms pre-joined
                )

# organize the raw data
comm_19 <- comm_19_raw |>
  pivot_wider(id_cols = GEOID, #can be =GEOID:NAME,
              names_from = variable,
              values_from = estimate:moe)

comm_19 <- tidy_acs_results(comm_19_raw) #utilizes a custom function see line 18

### 2022 data ----
comm_22_raw <- get_acs( 
                      geography = "tract",
                      variables = c(
                        wfh = "B08006_017",
                        transit = "B08006_008",
                        tot = "B08006_001"),
                      county = "Multnomah",
                      state = "OR",
                      year = 2022, 
                      survey = "acs5",
                      geometry = FALSE 
                )
comm_22 <- tidy_acs_results(comm_22_raw)
comm_22

# join years by location ----
comm_19_22 <- comm_19 |>
  inner_join( # only keeps consistent census geographies
    comm_22, 
    by = "GEOID",
    suffix = c("_19","_22") # adds suffix if there is conflict data
  ) |> 
  select(-starts_with("NAME"))

### create some change variables ----
comm_19_22 <- comm_19_22 |>
  mutate(wfh_chg = wfh_22 - wfh_19, # positive is increase
         transit_chg = transit_22 - transit_19
  )

 summary(
   comm_19_22 |> select(
   ends_with("chg") # only columns with change
   )
   )

 ### plot
 plot_19_22 <- comm_19_22 |>
   ggplot(aes(
     x = wfh_chg,
     y = transit_chg
   ))
 
plot_19_22 + 
  geom_point() + # plots data as points
  geom_smooth(method = "lm") + # shows trend line per selected method
  labs(x = "Change in WFH",
       y = "change in Transit",
       title = "ACS 2022 vs 2019 (5-year)") +
  annotate("text", 
           x = 800, # defines viewers max x
           y = 50,  # defines viewers max y
           label = paste("r = ",
                         round(
                           cor(comm_19_22$wfh_chg,
                             comm_19_22$transit_chg
                             ), 2 # rounds correlation 
                           )
           )
  )

# simple linear correlation (default Pearson) ----
cor(comm_19_22$wfh_chg, comm_19_22$transit_chg) 

# create a model ----
mod_19_22 <- lm( # linear model = LM
                transit_chg ~ wfh_chg, # model formula depvar ~ 1 + X1 + X2...
                data = comm_19_22)

# view model
summary(mod_19_22)

head(mod_19_22$coefficients)

# manipulate model; create scenarios
scenario1 <- comm_19_22 |>
  mutate(wfh_chg = wfh_chg * 1.5) # models increase of wfh change by 150%

pred_scenario1 <- predict( # predict based on modeled scenario
  mod_19_22,
  newdata = scenario1) 

sum(comm_19_22$transit_chg) # change in transit ridership per WFH scenario change

sum(pred_scenario1) # total change per WFH scenario change
