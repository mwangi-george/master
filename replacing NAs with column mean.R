# Written by: George Ngugi
# Written on: 2022-10-03
# Description: Replacing NA Values with the column mean --------------------------------

# remove NA values using the Zoo package
library(zoo)

# Creating data frame
Na_test <- data.frame(X1 = c(NA, 2:5, NA, 7:10),
                      X2 = c(1:8, NA, 4),
                      X3 = c(10:17, NA, 2))

# replace value in the 2nd row first column with NA
Na_test[2,1] <- NA

# replacing NA value in the first column with corresponding column mean
Na_test$X1[is.na(Na_test$X1)] <- mean(Na_test$X1, na.rm = T)

# this function replaces NA values with the mean of the corresponding column.
na.aggregate(Na_test$X1)

# replacing all NA values in the data frame with corresponding column mean
Na_test <- na.aggregate(Na_test)
