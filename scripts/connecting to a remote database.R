library(readxl)
library(tidyverse)
library(janitor)
library(ggthemes)
install.packages("RMySQL")
library(DBI)

excel_sheets("datasets/clean.xlsx")
options(scipen = 999)


# Import several excel sheets with lapply ---------------------------------
sheets <- excel_sheets("datasets/clean.xlsx")

# import all as list
all_sheets <- lapply(sheets, 
                     read_excel, 
                     path = "datasets/clean.xlsx")
# we can access the file using indexing
all_sheets[1]

# read sheet 1 of the excel workbook
read_excel("datasets/clean.xlsx", sheet = 1) %>% 
  # reshape the data into long format
  pivot_longer(data = ., cols = starts_with("19"), 
               names_to = "year", 
               values_to = "urban_pop") %>% 
  # change incorrect data types
  mutate(year = as.numeric(year)) %>% 
  # filter for rows of interest
  filter(country == "Kenya") %>% 
  # visualize the data with a line plot
  ggplot(aes(year, urban_pop))+
  geom_line(size = 1)+
  theme_economist()+
  labs(title = "Kenyan Urban Population between 1960 and 1966",
       subtitle = "(Source::DataCamp Datasets)",
       x = "Time",
       y = "Urban Population")+
  # adjust y axis limits
  ylim(550000, 950000)
  

# Connect to a database ---------------------------------------------------


# If the MySQL database is a remote database hosted on a server, 
# you'll also have to specify the following arguments in 
# dbConnect(): dbname, host, port, user and password. 
# Most of these details have already been provided.

# creating connection to a remote database
con <- dbConnect(RMySQL::MySQL(), # construct driver connection
                  dbname = "courses", # database name
                  host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com",
                  port = 3306,
                  user = "student",
                  password = "datacamp")

# print all tables in the database
dbListTables(con)

# read a table in the database
dbReadTable(con, "users")

# read mutiple tables 
table_list <- dbListTables(con)
# use lapply
tables <- lapply(table_list, dbReadTable, conn = con)


# Create a data frame, short, that selects the id and name columns 
# from the users table where the number of characters in the name 
# is strictly less than 5.

# Create data frame short
short <- dbGetQuery(conn = con, 
                    statement = "select id, name from users 
                    where CHAR_LENGTH(name) < 5")






