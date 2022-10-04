Continued - Generating, reading and extracting data
================
George Ngugi
2022-10-04

-   <a href="#operating-with-the-titanic-dataset"
    id="toc-operating-with-the-titanic-dataset">Operating with the titanic
    dataset</a>

Loading necessary libraries

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
    ## ✔ ggplot2 3.3.6      ✔ purrr   0.3.4 
    ## ✔ tibble  3.1.8      ✔ dplyr   1.0.10
    ## ✔ tidyr   1.2.0      ✔ stringr 1.4.1 
    ## ✔ readr   2.1.2      ✔ forcats 0.5.2 
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

### Operating with the titanic dataset

``` r
# loading data set
titanic <- read.csv("datasets/titanic.csv", header = T, stringsAsFactors = F)
```

1.  Understanding the structure of the dataset

``` r
str(titanic)
```

    ## 'data.frame':    1313 obs. of  7 variables:
    ##  $ Index   : int  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ Name    : chr  "Allen, Miss Elisabeth Walton" "Allison, Miss Helen Loraine" "Allison, Mr Hudson Joshua Creighton" "Allison, Mrs Hudson JC (Bessie Waldo Daniels)" ...
    ##  $ PClass  : chr  "1st" "1st" "1st" "1st" ...
    ##  $ Age     : num  29 2 30 25 0.92 47 63 39 58 71 ...
    ##  $ Sex     : chr  "female" "female" "male" "female" ...
    ##  $ Survived: int  1 0 0 0 1 1 1 0 1 0 ...
    ##  $ SexCode : int  1 1 0 1 0 0 1 0 1 0 ...

2.  Calculate the number of observations of `Age` variable are missing
    in the dataset

``` r
titanic[is.na(titanic$Age),] %>% 
  nrow()
```

    ## [1] 557

``` r
# Alternatively 
sum(is.na(titanic$Age))
```

    ## [1] 557

``` r
# Alternatively, we can look at the summary at the number of NA's using the summary function
summary(titanic$Age)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    ##    0.17   21.00   28.00   30.40   39.00   71.00     557

3.  Make a new variable called `Status`, based on the `Survived`
    variable already in the dataset. For passengers that did not
    survive, Status should be `dead`, for those who did, Status should
    be `alive`. Make sure this new variable is a factor.

``` r
# Using dplyr verb (mutate)
titanic %>% 
  mutate(Status = if_else(Survived == 1, "alive", "dead")) %>% head()
```

    ##   Index                                          Name PClass   Age    Sex
    ## 1     1                  Allen, Miss Elisabeth Walton    1st 29.00 female
    ## 2     2                   Allison, Miss Helen Loraine    1st  2.00 female
    ## 3     3           Allison, Mr Hudson Joshua Creighton    1st 30.00   male
    ## 4     4 Allison, Mrs Hudson JC (Bessie Waldo Daniels)    1st 25.00 female
    ## 5     5                 Allison, Master Hudson Trevor    1st  0.92   male
    ## 6     6                            Anderson, Mr Harry    1st 47.00   male
    ##   Survived SexCode Status
    ## 1        1       1  alive
    ## 2        0       1   dead
    ## 3        0       0   dead
    ## 4        0       1   dead
    ## 5        1       0  alive
    ## 6        1       0  alive

``` r
# Achieving the same results working in base R
transform(titanic, 
          Status = ifelse(Survived == 1, "alive", "dead")) %>% head()
```

    ##   Index                                          Name PClass   Age    Sex
    ## 1     1                  Allen, Miss Elisabeth Walton    1st 29.00 female
    ## 2     2                   Allison, Miss Helen Loraine    1st  2.00 female
    ## 3     3           Allison, Mr Hudson Joshua Creighton    1st 30.00   male
    ## 4     4 Allison, Mrs Hudson JC (Bessie Waldo Daniels)    1st 25.00 female
    ## 5     5                 Allison, Master Hudson Trevor    1st  0.92   male
    ## 6     6                            Anderson, Mr Harry    1st 47.00   male
    ##   Survived SexCode Status
    ## 1        1       1  alive
    ## 2        0       1   dead
    ## 3        0       0   dead
    ## 4        0       1   dead
    ## 5        1       0  alive
    ## 6        1       0  alive

4.  Add the new variable to the dataframe and convert it to a factor

``` r
titanic <- titanic %>% 
  mutate(Status = if_else(Survived == 1, "alive", "dead")) %>%
  mutate(Status = as.factor(Status)) %>% 
  mutate(Status = factor(Status, levels = c("alive", "dead")))

# check factor levels of Status
levels(titanic$Status)
```

    ## [1] "alive" "dead"

5.  Count the number of passengers in each of the classes `PClass`

``` r
table(titanic$PClass)
```

    ## 
    ##   * 1st 2nd 3rd 
    ##   1 322 279 711

``` r
# Alternatively
titanic %>% 
  select(PClass) %>% 
  table()
```

    ## PClass
    ##   * 1st 2nd 3rd 
    ##   1 322 279 711

6.  Using grep, find the six passengers with the last name ’Fortune’.
    Make this subset into a new dataframe. Did they all survive?

``` r
titanic[grep("Fortune",titanic$Name),]
```

    ##     Index                               Name PClass Age    Sex Survived SexCode
    ## 100   100      Fortune, Miss Alice Elizabeth    1st  24 female        1       1
    ## 101   101      Fortune, Mr Charles Alexander    1st  19   male        0       0
    ## 102   102          Fortune, Miss Ethel Flora    1st  28 female        1       1
    ## 103   103                Fortune, Miss Mabel    1st  23 female        1       1
    ## 104   104                   Fortune, Mr Mark    1st  64   male        0       0
    ## 105   105 Fortune, Mrs Mark (Mary McDougald)    1st  60 female        1       1
    ##     Status
    ## 100  alive
    ## 101   dead
    ## 102  alive
    ## 103  alive
    ## 104   dead
    ## 105  alive
