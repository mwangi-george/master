library(tidyverse)
library(babynames)

install.packages("babynames")

income <- c(72, 92828, 2929, 23833990)

pe <- format(income, digits = 2, scientific = F, big.mark = ",")

class(pe)
class(as.numeric(pe))

spotify <- read.csv("datasets/spotify.csv")

View(spotify)

spotify %>%
  mutate(Despacito = format(Despacito, digits = 2, scientific = F, big.mark = ",")) %>%
  str()

# From the format() exercise
x <- c(0.0011, 0.011, 1)
y <- c(1.0011, 2.011, 1)

# formatC() on x with format = "f", digits = 1
formatC(x, format = "f", digits = 1)

# formatC() on y with format = "f", digits = 1
formatC(y, format = "f", digits = 1)

# Format percent_change to one place after the decimal point
formatC(percent_change, format = "f", digits = 1)

# percent_change with flag = "+"
formatC(percent_change, format = "f", digits = 1, flag = "+")


# Format p_values using format = "g" and digits = 2
formatC(p_values, format = "g", digits = 2)


#The vectors you pass to paste() are pasted together 
#element by element, using the sep argument to combine them.
#If the vectors passed to paste() aren't the same length, 
#the shorter vectors are recycled up to the length of the 
#longest one.
#Only use collapse if you want a single string as output. 
#collapse specifies the string to place between different elements.


# stringr functions -------------------------------------------------------

# pasting strings together
str_c("I want to go", "home", sep = " ")
# by default, str_c uses an empty separator 
# it also returns NA when we combine a string with a missing value
str_c("james", NA)

# Extracting vectors for boys' and girls' names
babynames_2014 <- filter(babynames, year == 2014)
boy_names <- filter(babynames_2014, sex == "M")$name
girl_names <- filter(babynames_2014, sex == "F")$name

# Take a look at a few boy_names
head(boy_names)

# Find the length of all boy_names
boy_length <- str_length(boy_names)

# Take a look at a few lengths
head(boy_length)

# Find the length of all girl_names
girl_length <- str_length(girl_names)

# Find the difference in mean length
mean(girl_length)-mean(boy_length)

# Confirm str_length() works with factors
head(str_length(factor(boy_names)))


# Extracting strings with str_sub
str_sub(c("Bruce", "Wayne"), start = 1, end = 4)
str_sub(c("Bruce", "Wayne"), -4, -1)

# Extract first letter from boy_names
boy_first_letter <- str_sub(boy_names, 1,1)

# Tabulate occurrences of boy_first_letter
table(boy_first_letter)

# Extract the last letter in boy_names, then tabulate
boy_last_letter <- str_sub(boy_names, -1,-1)
table(boy_last_letter)

# Extract the first letter in girl_names, then tabulate
girl_first_letter <- str_sub(girl_names, 1, 1)
table(girl_first_letter)

# Extract the last letter in girl_names, then tabulate
girl_last_letter <- str_sub(girl_names, -1,-1)
table(girl_last_letter)


# str_detect
# Look for pattern "zz" in boy_names
contains_zz <- str_detect(boy_names, pattern = fixed("zz"))

# Examine str() of contains_zz
str(contains_zz)

# How many names contain "zz"?
sum(contains_zz)

# Which names contain "zz"?
boy_names[contains_zz]



# subsetting 
# Find boy_names that contain "zz"
str_subset(boy_names, "zz")

# Find girl_names that contain "zz"
str_subset(girl_names, "zz")

# Find girl_names that contain "U"
starts_U <- str_subset(girl_names, fixed("U"))
starts_U

# Find girl_names that contain "U" and "z"
str_subset(starts_U, "z")


# counting patterns 
# Count occurrences of "a" in girl_names
number_as <- str_count(girl_names, fixed("a"))

# Count occurrences of "A" in girl_names
number_As <- str_count(girl_names, fixed("A"))