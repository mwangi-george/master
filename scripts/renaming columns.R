# Renaming Variables ------------------------------------------------------

# laod dataset for practice
data("airquality")

# print variable names of the dataset
names(airquality)
## "Ozone"   "Solar.R" "Wind"    "Temp"    "Month"   "Day" 

# Renaming one variable ---------------------------------------------------

# Renaming "Day" to "Week_day in base R
colnames(airquality)[colnames(airquality) == "Day"] <- "Week_day"

# print variable names of the dataset
names(airquality)
## "Ozone"    "Solar.R"  "Wind"     "Temp"     "Month"    "Week_day"

# Renaming all variables  -------------------------------------------------

colnames(airquality) <- c("var1", "var2", "var3", "var4", "var5", "var6")

# print variable names of the dataset
names(airquality)
##"var1" "var2" "var3" "var4" "var5" "var6"

# Renaming some variables  ------------------------------------------------

colnames(airquality)[colnames(airquality) %in% c("var1", "var4", "var6")] <- c("Ozone", "Temp", "Week")

# print variable names of the dataset
names(airquality)
## "Ozone" "var2"  "var3"  "Temp"  "var5"  "Week" 