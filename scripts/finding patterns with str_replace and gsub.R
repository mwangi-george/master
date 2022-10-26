
# Using str_replace and str_replace_all  ----------------------------------

# Written by: George Ngugi
# Written on: 2022-09-29

# load necessary packages
library(tidyverse)
getwd()

data1 <- read_csv("C:\\Users\\Admin\\Documents\\R_docs\\data\\datafiniti\\7282_1.csv")
data2 <- read_csv("C:\\Users\\Admin\\Documents\\R_docs\\data\\datafiniti\\Datafiniti_Hotel_Reviews.csv")
data3 <- read_csv("C:\\Users\\Admin\\Documents\\R_docs\\data\\datafiniti\\Datafiniti_Hotel_Reviews_Jun19.csv")

attach(data1)
names(data1)

test1 <- data1 %>% 
  select(reviews.date, reviews.dateAdded) %>% 
  filter(city %in% "Raymond")

attach(test1)

# replace the "-" in the reviews.date column with "."
# method 1
test1 %>% 
  mutate(reviews.date = gsub(reviews.date, 
                             pattern = "-", 
                             replacement = "."))

# method two using str_replace_all
test1 %>% 
  mutate(reviews.date = str_replace_all(string = reviews.date, 
                                        pattern = "-", 
                                        replacement = ".")
  ) %>% 
  head(3)

# replace the first "-" in the reviews.date column with "."
test1 %>% 
  mutate(reviews.date = str_replace(string =reviews.date,
                                    pattern = "-",
                                    replacement = ".")
  ) %>% 
  head(3)

# replace all the patterns in the reviews.dateAdded column with "sep" 
test1 %>% 
  mutate(reviews.dateAdded = str_replace_all(string = reviews.dateAdded,
                                             pattern = "[-:]",
                                             replacement = "sep")
  ) %>% 
  head(3)

# remove a single pattern in the whole data frame using the lapply ()
data.frame(lapply(test1, 
                  function(x)
                  {str_replace_all(x,
                                   pattern = "-",
                                   replacement = ".")
                  }
)
) %>% head(3)


# replace all "-" in the data frame data1 with "." and print the first 3 rows
data.frame(lapply(data1,
                  function(x)
                  {str_replace_all(x,
                                   pattern = "-",
                                   replacement = ".")
                  }
)
) %>% head(3)

# repeat the above step using gsub()
data.frame(lapply(data1,
                  function(x)
                  {gsub(x,
                        pattern = "-",
                        replacement = ".")
                  }
)
) %>% 
  head(3)

# replace all "-" and ":" in the dataframe data1 with "." and print the first 3 rows
data.frame(lapply(data1,
                  function(x)
                  {str_replace_all(x,
                                   pattern = "[-:]",
                                   replacement = ".")
                  }
)
) %>% 
  head(3)
