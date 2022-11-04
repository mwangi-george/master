# function to load most commonly used libraries

essential_libraries <- function(x){
  pacman::p_load(tidyverse,
                 data.table, 
                 janitor,
                 tibble, 
                 gapminder, 
                 visdat, 
                 lubridate, 
                 assertive, 
                 infer, 
                 DBI
  )
}

# load 
essential_libraries()

callLog <- fread("datasets/call_log_2020.csv") 
glimpse(callLog)
view(callLog)

sum(duplicated(callLog))

callLog <- callLog %>% clean_names()

callLog %>% 
  # change columns to the correct data types
  mutate(from_number = as.numeric(from_number),
         to_number = as.numeric(to_number),
         type = as.factor(type)) %>% 
  # remove rows where name is "Unknown" and duration is zero
  filter(!str_detect(name, "Unknown"),
         !str_detect(duration, "0s")) %>% 
  # create a rowid column to uniquely identify each observation
  rowid_to_column() %>%  
  # remove the unnecessary serial number column
  select(-sr_no) %>%
  # remane rowid column as call_id
  rename(call_id = rowid) %>% 
  # separate the name column into first name and last names
  separate(name, into = c("first_name", "last_name")) %>% 
  # remove rows where the last_name is NA
  filter(!is.na(last_name)) %>% 
  # take to_number back to string type to allow for manipulation
  mutate(to_number = as.character(to_number),
         # remove country code in the column
         to_number = str_remove_all(to_number, "254"),
         # change it back to numeric
         to_number = as.numeric(to_number))-> callLog_changed

# filter where duration does not contain "s" string 
callLog_changed %>% 
  # filter to get secs 
  filter(!str_detect(duration, "m")) -> duration_secs

# filter where duration contains "m" string 
callLog_changed %>% 
  # filter to get mins and secs
  filter(str_detect(duration, "m")) -> duration_mins_secs

# remove all "s" in duration secs to get duration as integer
duration_secs %>% 
  mutate(duration = str_remove_all(duration, "s"),
         duration = as.numeric(duration)) %>% 
  # rename the duration column to duration_in_secs and overwrite duration_secs
  select(call_id:time, duration_in_secs = duration, type) -> duration_secs

duration_mins_secs %>% 
  # separate duration into "mins" and "secs"
  separate(duration, into = c("mins", "secs"), sep = " ") %>% 
  # remove strings and change to the correct data types
  mutate(mins = str_remove_all(mins, "m"),
         mins = as.numeric(mins),
         secs = str_remove_all(secs, "s"),
         secs = as.numeric(secs),
         # convert mins to secs by multiplying by 60
         mins = mins*60, 
         # add the mins and secs columns together
         duration_in_secs = mins+secs) %>% 
  # select the columns in the correct order and overwrite duration_mins_secs
  select(call_id:time, duration_in_secs, type) -> duration_mins_secs

# bind duration_mins_secs and duration_secs together and overwrite callLog_changed
duration_mins_secs %>% 
  bind_rows(duration_secs) %>% 
  arrange(call_id)-> callLog_changed

# raname the tables as calls
calls <- callLog_changed

# Exploratory Analysis -------------------------------------------

# What is the shape of the distribution of duration_in_secs?
calls %>% 
  ggplot(aes(log(duration_in_secs), fill = type))+
  geom_histogram(binwidth = 1)

# How many missed calls did I get?
calls %>% 
  filter(type == "Missed") %>% nrow()

# On Which date and time did I receive the call that had the longest duration?
calls %>% 
  arrange(-duration_in_secs) %>% 
  slice_head ()%>% 
  select(date, time)

# On Which date did I make the most calls?
calls %>% 
  count(date, type, sort = T) # 2022-04-10 Outgoing 14

### Who and who did I call on the date I made the most calls?
## sort the results in descending order of duration
calls %>% 
  filter(date == "2022-04-10" & type == "Outgoing") %>% 
  arrange(-duration_in_secs) %>% view()

# How many incoming calls did I reject?
calls %>% 
  filter(type == "Rejected") %>% nrow()

# How much time (in hours) did I take in outgoing calls and incoming calls?

calls %>% 
  group_by(type) %>% 
  summarise(total_time_outgoing = sum(duration_in_secs)) %>% 
  mutate(total_time_outgoing_hours = total_time_outgoing/3600)

# Who are the first ten people I called the most times and from which number?
calls %>% 
  filter(type == "Outgoing") %>% 
  count(first_name, last_name, from_number, sort = T) %>%
  head(10)

# Who are the first ten people that called me most times and which of my numbers they use?
calls %>% 
  filter(type == "Incoming") %>% 
  count(first_name, last_name, from_number, sort = T) %>%
  head(10)










