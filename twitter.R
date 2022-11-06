
# libraries
pacman::p_load(tidyverse, lubridate, data.table)

# read data(note, I reformatted the data into csv type, since readxl functions are slow)
tripdata1 <- fread("datasets/tripdata.csv")

tripdata <- slice_sample(tripdata, prop = 0.2)

write_csv(tripdata, "datasets/tripdata.csv")
# I will just use a sample of 10 rows for demonstration
sample_data <- tripdata %>% 
  slice_sample(n = 10) %>% 
  # create a column showing time difference in minutes
  mutate(time = as.POSIXct(ended_at, 
                           format = "%m/%d/%Y %H:%M")- as.POSIXct(started_at,
                                                                  format = "%m/%d/%Y %H:%M")) %>% 
  view()

# the resulting is a columnn with time differences that can easily be visualized
class(sample_data$time)
## [1] "difftime"

# if you want, you can mutate it to get hours or days
# I hope this solves your problem


library(lubridate)
library(readr)
library(dplyr)
library(ggplot2)

# Import "akl_weather_hourly_2016.csv"
akl_hourly_raw <- read_csv("akl_weather_hourly_2016.csv")

# Print akl_hourly_raw
akl_hourly_raw

# Use make_date() to combine year, month and mday 
akl_hourly  <- akl_hourly_raw  %>% 
  mutate(date = make_date(year = year, month = month, day = mday))

# Parse datetime_string 
akl_hourly <- akl_hourly  %>% 
  mutate(
    datetime_string = paste(date, time, sep = "T"),
    datetime = ymd_hms(datetime_string)
  )

# Print date, time and datetime columns of akl_hourly
akl_hourly %>% select(date, time, datetime)

# Plot to check work
ggplot(akl_hourly, aes(x = datetime, y = temperature)) +
  geom_line()


# Examine the head() of release_time
head(release_time)

# Examine the head() of the months of release_time
head(month(release_time))

# Extract the month of releases 
month(release_time) %>% table()

# Extract the year of releases
year(release_time) %>% table()

# How often is the hour before 12 (noon)?
mean(hour(release_time) < 12)

# How often is the release in am?
mean(am(release_time))


library(ggplot2)

# Use wday() to tabulate release by day of the week
wday(releases$datetime) %>% table()

# Add label = TRUE to make table more readable
wday(releases$datetime, label = T) %>% table()

# Create column wday to hold labelled week days
releases$wday <- wday(releases$datetime, label = T)

# Plot barchart of weekday by type of release
ggplot(releases, aes(wday)) +
  geom_bar() +
  facet_wrap(~ type, ncol = 1, scale = "free_y")