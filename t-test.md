Conducting a t test
================
Mwangi George
2022-10-14

### Introduction.

According to
[Scribbr.com](https://www.scribbr.com/statistics/t-test/#:~:text=A%20t%2Dtest%20is%20a,are%20different%20from%20one%20another.),
a t-test is a ” statistical test that is used to compare the means of
two groups. It is often used in hypothesis testing to determine whether
a process or treatment actually has an effect on the population of
interest, or whether two groups are different from one another”. This
paper provides a quick guide to conduct a t-test in R. I am going to use
the gapminder data set from the `gapminder` package”.

**Loading Important Libraries**

``` r
# the p_load from the pacman package allows for loading multiple libraries at once.
pacman::p_load(tidyverse, gapminder)
```

**Loading data set**

``` r
gapminder <- gapminder
```

Using the gapminder data, I can test whether there exists a difference
in the gdp per capita of countries in Europe and those in Asia. The
first thing before conducting a t test is to define the level of
significance to use and that the data is well formatted. (For this
exercise, I will use 5% level of significance).

### Hypothesis Stating

-   The null hypothesis (H0) is that the true difference between mean
    gdp per capita of Europe and Asia is zero.

-   The alternate hypothesis (Ha) is that the true difference between
    mean gdp per capita of Europe and Asia is different from zero.

**Data Wrangling**

``` r
df <- gapminder %>% 
  filter(continent %in% c("Europe", "Asia")) %>%  # filters the rows of interest
  group_by(continent) %>%                         # groups the data by continent
  select(continent, gdpPercap)                    # select the variables of interest.
  
# print the first 5 rows of df
head(df, 5)
```

    ## # A tibble: 5 × 2
    ## # Groups:   continent [1]
    ##   continent gdpPercap
    ##   <fct>         <dbl>
    ## 1 Asia           779.
    ## 2 Asia           821.
    ## 3 Asia           853.
    ## 4 Asia           836.
    ## 5 Asia           740.

### Conducting t-test

``` r
# Disable the scientific notation for test output
options(scipen = 999)

# t-test
t.test(gdpPercap ~ continent, data = df)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  gdpPercap by continent
    ## t = -7.6278, df = 693.01, p-value = 0.00000000000007904
    ## alternative hypothesis: true difference in means between group Asia and group Europe is not equal to 0
    ## 95 percent confidence interval:
    ##  -8257.753 -4876.897
    ## sample estimates:
    ##   mean in group Asia mean in group Europe 
    ##              7902.15             14469.48

### Output Interpretation

The p-Value (0.00000000000007904) is lower than 0.05 thus we reject the
null hypothesis and conclude that the gdp per capita between Europe and
Asia is Statistically different from zero.

[Twitter](https://www.twitter.com/mwangi__george)
