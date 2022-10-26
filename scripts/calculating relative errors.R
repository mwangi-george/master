##------------Calculating relative errors--------------##
The size of the sample you take affects how accurately the point estimates 
reflect the corresponding population parameter. For example, when you calculate 
a sample mean, you want it to be close to the population mean. However, 
if your sample is too small, this might not be the case.

The most common metric for assessing accuracy is relative error. 
This is the absolute difference between the population parameter and the 
point estimate, all divided by the population parameter. It is sometimes 
expressed as a percentage.


# Generate a simple random sample of 10 rows 
attrition_srs10 <- attrition_pop %>%
  slice_sample(n = 10)

# Calculate the proportion of employee attrition in the sample
mean_attrition_srs10 <- attrition_srs10 %>%
  summarize(mean_attrition = mean(Attrition == "Yes"))

# Calculate the relative error percentage
rel_error_pct10 <- 100 * abs(mean_attrition_pop - mean_attrition_srs10)/
  mean_attrition_pop

# See the result
rel_error_pct10