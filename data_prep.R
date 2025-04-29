library(here)
library(data.table)
library(jsonlite)
library(lubridate)

here::i_am("data_prep.R")

canada_csv  <- here("data", "canada_border_data.csv")
usa_url <- "https://data.bts.gov/resource/keg4-3bc2.json?$limit=500000"

df_1 <- fread(canada_csv)

df_1[, PortCode := as.integer(sub(" -.*$", "", `Port of Entry`))]

df_1[, Date := ymd(Date)]

date_min <- as.Date("2018-01-01")
date_max <- as.Date("2019-12-31")

df_1  <- df_1[ Date >= date_min & Date <= date_max ]