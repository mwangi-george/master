library(gapminder)
library(dplyr)
library(ggplot2)

gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Scatter plot comparing pop and gdpPercap, with both axes on a log scale
gapminder_1952 %>%
  ggplot(aes(pop, gdpPercap))+
  geom_point()+
  scale_x_log10()+
  scale_y_log10()


# Scatter plot comparing gdpPercap and lifeExp, with color representing continent
# and size representing population, faceted by year

gapminder %>%
  ggplot(aes(gdpPercap, lifeExp, col = continent,
             size = pop))+
  geom_point()+
  theme_classic()+
  scale_x_log10()+
  facet_wrap(~ year)


# Find median life expectancy and maximum GDP per capita in each continent in 1957
gapminder %>%
  filter(year == 1957) %>%
  group_by(continent) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))


# Find median life expectancy and maximum GDP per capita in each continent/year combination
gapminder %>%
  group_by(continent, year) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))


by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))

# Create a scatter plot showing the change in medianLifeExp over time
by_year %>% 
  ggplot(aes(year, medianLifeExp))+
  geom_point() +
  expand_limits(y = 0)

# Summarize the median GDP and median life expectancy per continent in 2007
by_continent_2007 <- gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarize(medianLifeExp =median(lifeExp),
            medianGdpPercap = median(gdpPercap))

# Use a scatter plot to compare the median GDP and median life expectancy
by_continent_2007 %>%
  ggplot(aes(medianGdpPercap, medianLifeExp, col = continent))+
  geom_point()



# Summarize the median gdpPercap by year & continent, save as by_year_continent
by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap by continent over time
by_year_continent %>%
  ggplot(aes(year, medianGdpPercap, col = continent))+
  geom_line()+
  expand_limits(y = 0)


# Summarize the median gdpPercap by continent in 1952
by_continent <- gapminder %>%
  filter(year == 1952) %>%
  group_by(continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

by_continent

# Create a bar plot showing medianGdp by continent
by_continent %>%
  ggplot(aes(continent, medianGdpPercap))+
  geom_col()


gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Create a histogram of population (pop), with x on a log scale
gapminder_1952 %>%
  ggplot(aes(pop))+
  geom_histogram()+
  scale_x_log10()

counties_selected %>%
  # Add population_walk containing the total number of people who walk to work 
  mutate(population_walk = population * walk / 100) %>%
  # Count weighted by the new column, sort in descending order
  count(state, wt = population_walk, sort = TRUE)

# Find number of counties per state, weighted by citizens, sorted in descending order
counties_selected %>%
  count(state, wt = citizens, sort = T)

# Use count to find the number of counties in each region
counties_selected %>%
  count(region, sort = TRUE)


counties_selected %>%
  # Find the total population for each combination of state and metro
  group_by(state, metro) %>%
  summarize(total_pop = sum(population)) %>%
  # Extract the most populated row for each state
  top_n(1, total_pop) %>%
  # Count the states with more people in Metro or Nonmetro areas
  ungroup() %>%
  count(metro)

counties <- readRDS("datasets/counties.rds")
counties %>% 
  select(last_col())



counties %>%
  # Count the number of counties in each state
  count(state) %>%
  # Rename the n column to num_counties
  rename(num_counties = n)

counties %>%
  # Keep the state, county, and populations columns, and add a density column
  transmute(state, county, population, density = population/land_area) %>%
  # Filter for counties with a population greater than one million 
  filter(population > 1000000) %>%
  # Sort density in ascending order 
  arrange(density)



# Change the name of the unemployment column
counties %>%
  rename(unemployment_rate = unemployment)

# Keep the state and county columns, and the columns containing poverty
counties %>%
  select(state, county, contains("poverty"))

# Calculate the fraction_women column without dropping the other columns
counties %>%
  mutate(fraction_women = women / population)

# Keep only the state, county, and employment_rate columns
counties %>%
  transmute(state, county, employment_rate = employed / population)