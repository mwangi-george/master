pacman::p_load(tidyverse, visdat, assertive, forcats, data.table, janitor, tibble, lubridate)

audible <- fread("datasets/audible_uncleaned.csv") %>% clean_names()


# Essentials --------------------------------------------------------------

# data structure
glimpse(audible)

# Remove duplicates 
distinct(audible)

# add a rowid column for uniqueness
audible <- audible %>% rowid_to_column()

# Rename variables --------------------------------------------------------

# renamed releasedate to release_date
audible <- audible %>% 
  rename(release_date = releasedate) 

# Wrangling time variable -------------------------------------------------

hrs_mins <- audible %>% 
  filter(!str_detect(time, "and")) 


hrs <- hrs_mins %>% 
  filter(str_detect(time, "hr")) %>% view()

mins <- hrs_mins %>% 
  filter(str_detect(time, "min"))

hrs <- hrs %>% 
  mutate(time = str_remove_all(time, "hr"),
         time = str_remove_all(time, "s"),
         time = str_trim(time),
         time = as.numeric(time),
         time = time * 60) %>% 
  rename(time_in_mins = time)

mins <- mins %>% 
  mutate(time = str_remove_all(time, "Less than"),
         time = str_remove_all(time, "minute"),
         time = str_remove_all(time, "mins"),
         time = str_remove_all(time, "min"),
         time = str_trim(time), 
         time = as.numeric(time)) %>% 
  rename(time_in_mins = time)

hrs_mins <- hrs %>% 
  bind_rows(mins) %>% 
  arrange(rowid) 

mins %>% 
  filter(rowid == 383) 

hrs_mins %>% 
  arrange(rowid)

hrs_and_mins <- audible %>% 
  filter(str_detect(time, "and"))

audible <- hrs_and_mins %>% 
  separate(time, into = c("hrs", "mins"), sep = "and") %>% 
  mutate(hrs = str_remove_all(hrs, "hrs"),
         hrs = str_remove_all(hrs, "hr"),
         mins = str_remove_all(mins, "mins"),
         mins = str_remove_all(mins, "min"),
         hrs = as.numeric(hrs),
         hrs = hrs*60, 
         mins = as.numeric(mins),
         time_in_mins = hrs + mins) %>%
  select(rowid, name, author, narrator, time_in_mins, 
         release_date, language, stars, price) %>% 
  bind_rows(hrs_mins) %>% 
  arrange(rowid)


# Wrangling release_date --------------------------------------------------

audible %>% 
  filter(!str_detect(release_date, "-"))


audible$release_date <- parse_date_time(
  audible$release_date,  
  orders = "%d/%m/%y")

audible %>% 
  filter(!is.Date(release_date)) %>% 
  view()

class(audible$release_date)

audible <- audible %>% 
  mutate(release_date = as.Date(release_date))


# Wrangling language ------------------------------------------------------

class(audible$language)

audible %>% 
  mutate(language = as.factor(language),
         language = str_to_title(language)) %>%
  count(language, sort = T) %>% 
  mutate(percent = n/sum(n)*100) %>% 
  filter(percent < 1) %>% 
  select(language) -> below_one_percent

other_categories <- c(below_one_percent$language)

audible <- audible %>% 
  mutate(language = as.factor(language),
         language = str_to_title(language))

language <- audible %>% 
  count(language)

# use forcats to collapse language categories
audible <- audible %>% 
  mutate(language_collapsed = fct_collapse(language, other = other_categories)) %>% 
  select(-language) %>% 
  rename(language = language_collapsed) %>% 
  select(rowid, name, author, narrator, time_in_mins, 
         release_date, language, stars, price)

levels(audible$language)

# Wrangling price ---------------------------------------------------------

class(audible$price)


audible %>% 
  filter(rowid ==984)

audible_free <-  audible %>% 
  filter(str_detect(price, "Free")) %>% 
  mutate(price = if_else(price == "Free", 0, 1)) 

audible_not_free <- audible %>% 
  filter(!str_detect(price, "Free")) %>% 
  mutate(price_changed = str_remove_all(price, ",")) %>% 
  separate(price_changed, into = c("dollars", "cents")) %>%
  mutate(cents = as.numeric(cents),
         dollars = as.numeric(dollars),
         cents = cents/100,
         dollars_cents = dollars + cents) %>%
  select(-c("price", "dollars", "cents")) %>% 
  rename(price = dollars_cents)

audible_free %>% 
  bind_rows(audible_not_free) %>% 
  arrange(rowid) %>% view()


# Wrangling narrator ------------------------------------------------------

class(audible$narrator)

audible %>% 
  filter(!str_detect(narrator, "Narratedby:"))

audible %>% 
  mutate(narrator_changed = str_remove_all(narrator, "Narratedby:"))







