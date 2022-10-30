path <- file.path("C:", "Downloads", "cereal.csv")

read.csv(path, stringsAsFactors = F)
path
"D:\my sql data\customers.csv"

path <- file.path("D:", "my sql data", "marketing.csv")
read.csv(path, stringsAsFactors = F)

url <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1477/datasets/swimming_pools.csv"

pools1 <- read.csv(url, stringsAsFactors = T)
pools2 <- read.csv(url)
str(pools1)

# to see the files in the working directory 
dir()

# importing tab delimited files(.txt)
url_1 <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1477/datasets/hotdogs.txt"
read.delim(url_1, stringsAsFactors = F, header = F)

read.table(url_1, header = F, sep = "\t")


# readr 
library(readr)
url_2 <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1477/datasets/potatoes.csv"
read_csv(url_2)
url_3 <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1477/datasets/potatoes.txt"

properties <- c("area", "temp", "size", "storage", "method",
                "texture", "flavor", "moistness")

tab_sep <- read_tsv(url_3, col_names = properties)
write.table(tab_sep, "tab_sep.txt")
read_delim("tab_sep.txt", delim = "\t",
           skip = 2, n_max = 3)
library(data.table)
fread("tab_sep.txt") %>% 
  select(-V1)
fread(url_3)
fread("datasets/legos/sets.csv")

library(readxl)

excel_sheets("datasets/my_chess_data.xlsx")

read_excel("datasets/my_chess_data.xlsx", sheet = 1)


my_w <- lapply(excel_sheets("datasets/my_chess_data.xlsx"),
               read_excel,
               path = "datasets/my_chess_data.xlsx")
install.packages("gdata")

install.packages("XLConnect")
version


library(tibble)

table <- tribble(~ purple_link, ~ prop,
                 "Hello, old friend", 1/2,
                 "Amused", 1/6,
                 "Indifferent", 1/6,
                 "Annoyed", 1/6)