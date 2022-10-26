

##-------------Generating a bootstrap distribution------------------##

The process for generating a bootstrap distribution is remarkably similar 
to the process for generating a sampling distribution; only the first step is different.

To make a sampling distribution, you start with the population and sample 
without replacement. To make a bootstrap distribution, you start with a sample and 
sample that with replacement. After that, the steps are the same: calculate the summary 
statistic that you are interested in on that sample/resample, then replicate the process 
many times. In each case, you can visualize the distribution with a histogram.

# Generate 1 bootstrap resample
spotify_1_resample <- spotify_sample %>%
  slice_sample(prop = 1, replace = T)

# Calculate mean danceability of resample
mean_danceability_1 <- spotify_1_resample %>%
  summarize(mean_danceability = mean(danceability))%>%
  pull(mean_danceability)

# Replicate this 1000 times
mean_danceability_1000 <- replicate(
  n = 1000,
  expr = {
    spotify_1_resample <- spotify_sample %>% 
      slice_sample(prop = 1, replace = TRUE)
    spotify_1_resample %>% 
      summarize(mean_danceability = mean(danceability)) %>% 
      pull(mean_danceability)
  }
)

# Store the resamples in a tibble
bootstrap_distn <- tibble(
  resample_mean = mean_danceability_1000
)

# Draw a histogram of the resample means with binwidth 0.002
bootstrap_distn %>%
  ggplot(aes(resample_mean))+geom_histogram(binwidth = 0.002)


##-----------------Example 2-----------------###

# Generate a bootstrap distribution
mean_popularity_2000_boot <- replicate(
  # Use 2000 replicates
  n = 2000,
  expr = {
    # Start with the sample
    spotify_sample %>% 
      # Sample same number of rows with replacement
      slice_sample(n = 500, replace = T) %>% 
      # Calculate the mean popularity
      summarize(mean_popularity = mean(popularity)) %>% 
      # Pull out the mean popularity
      pull(mean_popularity)
  }
)

##----------------------compare with the sampling distribution below---------##

# Generate a sampling distribution
mean_popularity_2000_samp <- replicate(
  # Use 2000 replicates
  n = 2000,
  expr = {
    # Start with the population
    spotify_population %>% 
      # Sample 500 rows without replacement
      slice_sample(n = 500) %>% 
      # Calculate the mean popularity as mean_popularity
      summarize(mean_popularity = mean(popularity)) %>% 
      # Pull out the mean popularity
      pull(mean_popularity)
  }
)


The sampling distribution and the bootstrap distribution are closely related and so
is the code to generate them 

##------------------------NOTE-----------------------------##

While not the closest to the population standard deviation, the bootstrap 
distribution standard deviation is a better estimator of the population 
standard deviation compared to the sampling standard deviation

calculating the bootstrap distribution standard deviation.
sqrt(n) * sd(bootstrap_distribution$resample_mean)