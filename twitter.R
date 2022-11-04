
# libraries
pacman::p_load(tidyverse, lubridate, data.table)

# read data(note, I reformatted the data into csv type, since readxl functions are slow)
tripdata <- fread("datasets/tripdata.csv")

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
