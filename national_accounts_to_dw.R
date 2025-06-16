# Fetch GDP data from the ABS and publish to Datawrapper

library(readabs)
library(dplyr)
library(httr)
library(readr)

abs_key <- Sys.getenv("ABS_API_KEY")
if (abs_key != "") {
  set_abs_key(abs_key)
}

dw_key <- Sys.getenv("DW_API_KEY")
if (dw_key == "") {
  stop("DW_API_KEY environment variable not set")
}

# GDP chain volume measure, seasonally adjusted (series id may need updating)
gdp <- read_abs(series_id = "A2305846X") %>%
  select(date, value)

# Prepare Datawrapper request helpers
base_url <- "https://api.datawrapper.de/v3"
header <- add_headers(Authorization = paste("Bearer", dw_key))

# Create a new chart
create_res <- POST(
  url = paste0(base_url, "/charts"),
  header,
  body = list(title = "Australian GDP", type = "d3-lines"),
  encode = "json"
)
chart_id <- content(create_res)$id

# Upload data to the chart
csv_file <- tempfile(fileext = ".csv")
write_csv(gdp, csv_file)

PUT(
  url = paste0(base_url, "/charts/", chart_id, "/data"),
  header,
  body = list(file = upload_file(csv_file))
)

# Publish the chart
POST(
  url = paste0(base_url, "/charts/", chart_id, "/publish"),
  header
)
