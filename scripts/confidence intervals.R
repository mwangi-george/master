
##-----Generate a 95% confidence interval using the quantile method--##

conf_int_quantile <- bootstrap_distribution %>% 
  summarize(lower = quantile(resample_mean, 0.025),
            upper = quantile(resample_mean, 0.975))

# See the result
conf_int_quantile

##-----Generate a 95% confidence interval using the std error method----##

conf_int_std_error <- bootstrap_distribution %>% 
  summarize(point_estimate = mean(resample_mean),
            standrd_error = sd(resample_mean),
            lower = qnorm(0.025, point_estimate, standrd_error),
            upper = qnorm(0.975, point_estimate, standrd_error))