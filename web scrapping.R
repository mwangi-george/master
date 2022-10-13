# Written by: George Ngugi
# Written on: 2022-10-07
# Description: How to read html tables

# loading necessary packages
library(rvest)
library(tidyverse)

# https://en.wikipedia.org/wiki/Economy_of_Kenya
url <- read_html("https://en.wikipedia.org/wiki/Economy_of_Kenya")

alltables <- url %>% 
  html_table(fill = T)
my_table <-alltables[[3]]

data.frame(lapply(my_table, 
                 function(x)
                   {
                   gsub(x,
                        pattern = "Shillings",
                        replacement = "")
                 },
                 function(x)
                   {
                   gsub(x,
                        pattern = "Billion",
                        replacement = "")
                 }))




  