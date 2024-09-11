# Read in csv file using base R
read.csv("data/portal_stations.csv", stringAsFactors = F) # does not convert characters to vectors 
# sta_meta <- read.csv("data/portal_stations.csv", stringAsFactors = F) # assigns data to variable
# str(sta_meta) # structure of data
# head(sta_meta) # prints first 6 rows of data
# tail(sta_meta) # prints last 6 rows of data
# nrow(sta_meta) # number of rows of data
# 