# pacman::p_load(tidyverse, janitor, lubridate, data.table, infer, ggthemes)
pacman::p_load(tidyverse, janitor, lubridate, data.table, infer, ggthemes)

marketing <- read_csv("datasets/marketing.csv")

view(marketing)

marketing %>%
  filter(!complete.cases(.)) %>%
  view()

str(marketing)

marketing <- marketing %>%
  clean_names()


lm(sales ~ influencer + 0, data = marketing)

marketing %>%
  group_by(influencer) %>%
  summarise(mean_sales = mean(sales, na.rm = T)) %>%
  ggplot(aes(influencer, mean_sales)) +
  geom_col(fill = "blue", alpha = 0.5, width = 0.5) +
  theme(axis.title = element_text(
    size = 9,
    face = "bold", colour = "blue"
  ), plot.title = element_text(
    face = "bold",
    colour = "blue", hjust = 0.5
  ), panel.background = element_rect(fill = "white")) +
  labs(
    title = "Average sales by Influencer",
    y = "Mean Sales", colour = "black", fill = "black",
    alpha = 0.2
  )


tv <- lm(sales ~ tv, data = marketing)

tidy(tv) %>% view()
glance(tv) %>% view()
augment(tv) %>% view()

coefficients(tv)

ggplot(marketing, aes(tv, sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = F) +
  geom_point(data = tv_ad, color = "red", size = 1)

summary(residuals(tv))

residuals <- tibble(residuals = residuals(tv))

view(residuals)

ggplot(residuals, aes(residuals)) +
  geom_histogram(binwidth = 0.2)

autoplot(tv, which = 1:3, nrow = 3, ncol = 1)

marketing %>%
  summarise(
    max_tv = max(tv, na.rm = T),
    min_tv = min(tv, na.rm = T)
  )

tv_ad <- tibble(tv = 200)

tv_ad <- tv_ad %>%
  mutate(sales = 712.1559)


names(marketing)
social <- lm(I(sqrt(sales)) ~ I(sqrt(social_media)), data = marketing)
tidy(social)
glance(social) %>% view()

ggplot(marketing, aes(sqrt(social_media), sqrt(sales))) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

autoplot(social, which = 1:3, nrow = 3, ncol = 1)
residuals1 <- tibble(resids = residuals(social))

ggplot(data, aes(resids)) +
  geom_histogram(bins = 10)


means <- replicate(
  n = 1000,
  expr = {
    residual_sample <- residuals1 %>%
      slice_sample(prop = 1, replace = T)
    residual_sample %>%
      summarise(mean_residual = mean(resids)) %>%
      pull(mean_residual)
  }
)

as.tibble(means)
data <- as_tibble(means) %>%
  select(resids = value)


marketing %>% 
  group_by(influencer) %>% 
  summarise(mean_sales = mean(sales, na.rm = T))



# Ho: The true difference in sales across influencer groups is equal to zero
# Ha: The true difference in sales across influencer groups is not equal to zero

model <- lm(sales ~ influencer, data = marketing)

anova(model)


pairwise.t.test(
  marketing$sales,
  marketing$influencer,
  p.adjust.method = "bonferroni",
  alternative = "two.sided"
)

tidy(t.test(
  marketing$sales,
  alternative = "two.sided"
)) %>% view()






u <- 400
sd <- 25
n <- 50
x_bar <- 250
s <- 15

# Ho : u = 400
# Ha: u != 400
std_error <- sd/sqrt(n)
z <- (x_bar - u)/std_error
pnorm(z)

u <- 0.5
p <- 400/850

std_error <- sqrt(u*(1-u)/850)
z <- (p-u)/std_error
pnorm(z)

refine <- read_csv("https://raw.githubusercontent.com/Carl-4000/DataWranglingEx101/master/refine_original.csv")

refine %>%
  # clean variable names
  clean_names() %>%
  mutate(
    # clean string variables
    company = str_to_lower(company),
    company = str_to_title(company),
    company = str_replace_all(company,
      pattern = "0",
      replacement = "o"
    ),
    company = str_replace_all(company,
      pattern = "Ak Zo",
      replacement = "Akzo"
    ),
    country = str_to_title(country),
    city = str_to_title(city),
    name = str_to_title(name)
  ) %>%
  # separate columns
  separate(product_code_number,
    into = c("product_code", "product_number"),
    sep = "-"
  ) %>%
  # merge columns
  unite("geotag",
    address, city, country,
    sep = ","
  ) %>%
  view()



now <- as.POSIXct("2022-11-11 19:16:01", tz = Africa/Nairobi)
tz(now)


Sys.Date()
Sys.timezone()

parse_date_time("2022-11-11 19:16:01")






