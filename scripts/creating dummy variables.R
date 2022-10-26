# ifelse() for creating dummy variables

View(mtcars) #display the data frame mtcars

?mtcars # data frame description

names(mtcars) # show variable names

summary(mtcars$disp) # summary statisitcs of the variable disp

mtcars$disp_dummy <- ifelse(mtcars$disp > median(mtcars$disp), 1,0) # create a dummy variable for disp
# 1 if disp is greater than the median of the variable, 0 otherwise

library(dplyr)
# create dummy variable with the dplyr package
mtcars <- mtcars %>% 
  mutate(disp_dummy2 = if_else(disp > median(disp), 1, 0))

# create categorical variable for disp (disp_cat)
# define high if disp is greater than or equal to the 3rd quartile
# low if disp is lower than or equal to the 1st quartile
# mid-low if disp is less than the median disp
# mid-high if disp is greater than the median disp

mtcars <- mtcars %>% 
  mutate(disp_cat = if_else(disp >= quantile(disp, 0.75), "high",
                            if_else(disp <= quantile(disp, 0.25), "low",
                                    if_else(disp <= median(disp), "mid-low", "mid-high"))))


# create  multiple dummy variables for the newly created disp_cat variable
dummy <- as.data.frame(model.matrix(~ mtcars$disp_cat - 1))

# add the dummies to the mtcars data frame
mtcars <- mtcars %>% 
  mutate(dummy = dummy)

mtcars <- mtcars %>% 
  select(-disp_dummy2)


install.packages("fastDummies")
#syntax
dumm_cols(data, select_columns = NULL)
# select_colummns = NULL uses all character and factor columns to create dummy variables

