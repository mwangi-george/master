library(tidyverse)
library(data.table)
library(gdata)
read_csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/swimming_pools.csv") %>% view()
fread("http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/swimming_pools.csv")

read_tsv("http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/potatoes.txt")

url <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/latitude.xls"

path <- file.path("D:", "master/master/datasets/data.xls")
download.file(url, path)
read.xls("datasets/data.xls")

# https URL to the wine RData file.
url_rdata <- "https://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/wine.RData"

# Download the wine file to your working directory
download.file(url_rdata, "datasets/wine_local.RData")

# Load the wine data into your workspace using load()
load("datasets/wine_local.RData")

# Print out the summary of the wine data
summary(wine)
