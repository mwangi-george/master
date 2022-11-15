install.packages("naniar")
install.packages("ggthemes")
library(naniar)
# Create x, a vector, with values NA, NaN, Inf, ".", and "missing"
x <- c(NA, NaN, Inf, ".", "missing")

# Use any_na() and are_na() on to explore the missings
any_na(x)
are_na(x)

# Use n_miss() to count the total number of missing values in dat_hw
n_miss(dat_hw)

# Use n_miss() on dat_hw$weight to count the total number of missing values
n_miss(dat_hw$weight)

# Use n_complete() on dat_hw to count the total number of complete values
n_complete(dat_hw)

# Use n_complete() on dat_hw$weight to count the total number of complete values
n_complete(dat_hw$weight)

# Use prop_miss() and prop_complete() on dat_hw to count the total number of missing values in each of the variables
prop_miss(dat_hw)
prop_complete(dat_hw)

miss_var_summary(airquality)
miss_case_summary(airquality)
miss_var_table(airquality)
airquality %>% group_by(Month) %>% 
  miss_var_summary()
pedestrian

laterite <- read_csv("mobile_money_data.csv")

miss_var_span(laterite, var = agent_trust, span_every = 100) %>% view()
miss_var_summary(laterite) %>% view()
library(visdat)
vis_miss(laterite)

miss_var_run(laterite, v244) %>% 
  select(length = run_length, nulls = is_na) %>% 
  mutate(missing = if_else(nulls == "complete", 1*length, -1*length)) %>% 
  ggplot(aes(nulls, missing))+
  geom_line()

# Calculate the summaries for each run of missingness for the variable, hourly_counts
miss_var_run(pedestrian, var = hourly_counts)

# Calculate the summaries for each span of missingness, 
# for a span of 4000, for the variable hourly_counts
miss_var_span(pedestrian, var = hourly_counts, span_every = 4000)

# For each `month` variable, calculate the run of missingness for hourly_counts
pedestrian %>% group_by(month) %>% miss_var_run(var = hourly_counts)

# For each `month` variable, calculate the span of missingness 
# of a span of 2000, for the variable hourly_counts
pedestrian %>% group_by(month) %>% miss_var_span(var = hourly_counts, span_every = 2000) %>% view()


vis_miss(laterite, cluster = T)

gg_miss_var(laterite)
gg_miss_case(laterite, order_cases = F)

slice_head(laterite) %>% view()

miss_case_summary(laterite) %>% view()

laterite %>% 
  rowid_to_column() %>% 
  filter(rowid == 347) %>% view()
gg_miss_var(airquality, facet = Month)
gg_miss_upset(airquality)

gg_miss_upset(laterite)

sum(are_na(laterite$v244))
gg_miss_upset(airquality)
gg_miss_fct(airquality, fct = Month)
gg_miss_fct(laterite, fct = gender)


gg_miss_span(laterite, v244, span_every = 1000, fct = gender)


vis_miss(laterite, sort_miss = T)

# Visualize all of the missingness in the `riskfactors`  dataset
vis_miss(riskfactors)

# Visualize and cluster all of the missingness in the `riskfactors` dataset
vis_miss(riskfactors, cluster = TRUE)

# visualize and sort the columns by missingness in the `riskfactors` dataset
vis_miss(riskfactors, sort_miss = TRUE)

# Using the airquality dataset, explore the missingness pattern using gg_miss_upset()
gg_miss_upset(airquality)

# With the riskfactors dataset, explore how the missingness changes across the marital variable using gg_miss_fct()
gg_miss_fct(x = riskfactors, fct = marital)

# Using the pedestrian dataset, explore how the missingness of hourly_counts changes over a span of 3000 
gg_miss_span(pedestrian, var = hourly_counts, span_every = 3000)

# Using the pedestrian dataset, explore the impact of month by faceting by month
# and explore how missingness changes for a span of 1000
gg_miss_span(pedestrian, var = hourly_counts , span_every = 1000, facet = month)


late <- read.csv("mobile_money_data.csv")

late %>% 
  miss_scan_count(search = list("tvet")) %>% view()


# Print the top of the pacman data using `head()`
head(pacman)

# Replace the strange missing values "N/A", "na", and  
# "missing" with `NA` for the variables, year, and score
pacman_clean <- replace_with_na(
  data = pacman, replace = list(
    year = c("N/A", "na", "missing"),
    dcscore = c("N/A", "na", "missing")))

# Test if `pacman_clean` still has these values in it?
miss_scan_count(data = pacman_clean, search = list("N/A", "na", "missing"))