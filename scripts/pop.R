# load important packages
pacman::p_load(tidyverse, janitor)

# load data files
country_info <- read_csv("datasets/country_info.csv", 
                         show_col_types = F) %>% 
  # clean variable names 
  clean_names()

pop_data <- read_csv("datasets/pop_data.csv",
                     show_col_types = F)
# clean names behaves unexpectedly

# remove unnecessary columns
pop_data <- pop_data %>% 
  select(-c("Indicator Name", "Indicator Code"))

# manipulate the data
pop_data <- pop_data %>%
  # change to the long format
  pivot_longer(
    cols = -c("Country Code"),
    names_to = "year", values_to = "population") %>% 
  # rename country code column
  rename("country_code" = "Country Code")


pop_data %>% 
  # view rows not in country_info table 
  anti_join(country_info, by = "country_code")

# overwrite pop_data
pop_data <- pop_data %>% 
 # filter dirty rows
  filter(country_code != "INX") 

# structure of the data set
glimpse(pop_data)

# check for rows with missing data
pop_data[!complete.cases(pop_data), ] %>% 
  view()

# convert year to numeric
pop_data <- pop_data %>% 
  mutate(year = as.numeric(year))

glimpse(country_info)  

# replace nulls with NA in country info
data.frame(lapply(country_info,
                              function(x)
                                {
                                gsub(x,
                                     pattern = "null",
                                     replacement = NA)
                                }
                              )
                       ) -> country_info

# view distinct income groups 
unique(country_info$income_group)

# rename table name in country info
country_info %>% 
  rename("country_name" = "table_name") %>% view()

# join the two tables
pop_data %>% 
  inner_join(country_info, by = "country_code") %>% view()





