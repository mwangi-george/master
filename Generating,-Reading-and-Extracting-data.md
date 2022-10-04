Generating, reading and extracting data
================
George Ngugi
2022-10-04

Load necessary libraries

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

### Working with a single vector

The numbers below are the first ten days of rainfall amounts in 2021.
Read them into a vector `0.1 0.6 33.8 1.9 9.6 4.3 33.7 0.3 0.0 0.1`

``` r
# creating a vector rainfall
rainfall <- c(0.1, 0.6, 33.8, 1.9, 9.6, 4.3, 33.7, 0.3, 0.0, 0.1)
```

1.  Take a subset of the rainfall data where rain is larger than 10

``` r
# subsetting in base R
rainfall[rainfall>10]
```

    ## [1] 33.8 33.7

2.  What is the mean rainfall for days where the rainfall was at least
    4?

``` r
mean(rainfall[rainfall >= 4])
```

    ## [1] 20.35

3.  Subset the vector where it is either exactly zero, or exactly 9.6.

``` r
rainfall[rainfall == 0 | rainfall == 9.6]
```

    ## [1] 9.6 0.0

``` r
# Alternatively 
rainfall[rainfall %in% c(0, 9.6)]
```

    ## [1] 9.6 0.0

4.  What are the 15th, 21st, and 26th letters of the lowercase alphabet?

``` r
letters[15]
```

    ## [1] "o"

``` r
letters[21]
```

    ## [1] "u"

``` r
letters[26]
```

    ## [1] "z"

5.  What is the length of the alphabet

``` r
length(letters)
```

    ## [1] 26

6.  Sample (with replacemet) 20 letters from the lower alphabet. assign
    this to lets20

``` r
# sample
lets20 <- sample(letters, 20, replace = T)

# check if there are any duplicates in the lets20
any(duplicated(lets20))
```

    ## [1] TRUE

``` r
# if there duplicates, what are their indexes
which(duplicated(lets20))
```

    ## [1]  7  8  9 14 16 18 20

``` r
# Retrieve the duplicated letters
lets20[which(duplicated(lets20))]
```

    ## [1] "e" "o" "u" "s" "o" "s" "u"

### Basic Operations with the Cereal data

1.  Load the dataset and check its structure as well as the first five
    rows

``` r
# importing the file
Cereal <- read_csv("Cereal.csv", show_col_types = F)
```

    ## New names:
    ## • `` -> `...1`

``` r
# dataset structure
str(Cereal)
```

    ## spec_tbl_df [77 × 15] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ ...1    : num [1:77] 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ name    : chr [1:77] "100%_Bran" "100%_Natural_Bran" "All-Bran" "All-Bran_with_Extra_Fiber" ...
    ##  $ calories: num [1:77] 70 120 70 50 110 110 110 130 90 90 ...
    ##  $ protein : num [1:77] 4 3 4 4 2 2 2 3 2 3 ...
    ##  $ fat     : num [1:77] 1 5 1 0 2 2 0 2 1 0 ...
    ##  $ sodium  : num [1:77] 130 15 260 140 200 180 125 210 200 210 ...
    ##  $ fiber   : num [1:77] 10 2 9 14 1 1.5 1 2 4 5 ...
    ##  $ carbo   : num [1:77] 5 8 7 8 14 10.5 11 18 15 13 ...
    ##  $ sugars  : num [1:77] 6 8 5 0 8 10 14 8 6 5 ...
    ##  $ potass  : num [1:77] 280 135 320 330 NA 70 30 100 125 190 ...
    ##  $ vitamins: num [1:77] 25 0 25 25 25 25 25 25 25 25 ...
    ##  $ shelf   : num [1:77] 3 3 3 3 3 1 2 3 1 3 ...
    ##  $ weight  : num [1:77] 1 1 1 1 1 1 1 1.33 1 1 ...
    ##  $ cups    : num [1:77] 0.33 1 0.33 0.5 0.75 0.75 1 0.75 0.67 0.67 ...
    ##  $ rating  : num [1:77] 68.4 34 59.4 93.7 34.4 ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   ...1 = col_double(),
    ##   ..   name = col_character(),
    ##   ..   calories = col_double(),
    ##   ..   protein = col_double(),
    ##   ..   fat = col_double(),
    ##   ..   sodium = col_double(),
    ##   ..   fiber = col_double(),
    ##   ..   carbo = col_double(),
    ##   ..   sugars = col_double(),
    ##   ..   potass = col_double(),
    ##   ..   vitamins = col_double(),
    ##   ..   shelf = col_double(),
    ##   ..   weight = col_double(),
    ##   ..   cups = col_double(),
    ##   ..   rating = col_double()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

``` r
# view the first five rows
head(Cereal, 5)
```

    ## # A tibble: 5 × 15
    ##    ...1 name      calor…¹ protein   fat sodium fiber carbo sugars potass vitam…²
    ##   <dbl> <chr>       <dbl>   <dbl> <dbl>  <dbl> <dbl> <dbl>  <dbl>  <dbl>   <dbl>
    ## 1     1 100%_Bran      70       4     1    130    10     5      6    280      25
    ## 2     2 100%_Nat…     120       3     5     15     2     8      8    135       0
    ## 3     3 All-Bran       70       4     1    260     9     7      5    320      25
    ## 4     4 All-Bran…      50       4     0    140    14     8      0    330      25
    ## 5     5 Almond_D…     110       2     2    200     1    14      8     NA      25
    ## # … with 4 more variables: shelf <dbl>, weight <dbl>, cups <dbl>, rating <dbl>,
    ## #   and abbreviated variable names ¹​calories, ²​vitamins

2.  Add a new variable to the dataset called `totalcarb`, which is the
    sum of `carbo` and `sugars`.

``` r
Cereal$totalcarb <- Cereal$carbo + Cereal$sugars

# Alternatively 
Cereal$totalcarb <- with(Cereal, carbo + sugars)

# Alternatively 
transform(Cereal,
          totalcarb = carbo + sugars)
```

    ##    ...1                                   name calories protein fat sodium
    ## 1     1                              100%_Bran       70       4   1    130
    ## 2     2                      100%_Natural_Bran      120       3   5     15
    ## 3     3                               All-Bran       70       4   1    260
    ## 4     4              All-Bran_with_Extra_Fiber       50       4   0    140
    ## 5     5                         Almond_Delight      110       2   2    200
    ## 6     6                Apple_Cinnamon_Cheerios      110       2   2    180
    ## 7     7                            Apple_Jacks      110       2   0    125
    ## 8     8                                Basic_4      130       3   2    210
    ## 9     9                              Bran_Chex       90       2   1    200
    ## 10   10                            Bran_Flakes       90       3   0    210
    ## 11   11                           Cap'n'Crunch      120       1   2    220
    ## 12   12                               Cheerios      110       6   2    290
    ## 13   13                  Cinnamon_Toast_Crunch      120       1   3    210
    ## 14   14                               Clusters      110       3   2    140
    ## 15   15                            Cocoa_Puffs      110       1   1    180
    ## 16   16                              Corn_Chex      110       2   0    280
    ## 17   17                            Corn_Flakes      100       2   0    290
    ## 18   18                              Corn_Pops      110       1   0     90
    ## 19   19                          Count_Chocula      110       1   1    180
    ## 20   20                     Cracklin'_Oat_Bran      110       3   3    140
    ## 21   21                 Cream_of_Wheat_(Quick)      100       3   0     80
    ## 22   22                                Crispix      110       2   0    220
    ## 23   23                 Crispy_Wheat_&_Raisins      100       2   1    140
    ## 24   24                            Double_Chex      100       2   0    190
    ## 25   25                            Froot_Loops      110       2   1    125
    ## 26   26                         Frosted_Flakes      110       1   0    200
    ## 27   27                    Frosted_Mini-Wheats      100       3   0      0
    ## 28   28 Fruit_&_Fibre_Dates,_Walnuts,_and_Oats      120       3   2    160
    ## 29   29                          Fruitful_Bran      120       3   0    240
    ## 30   30                         Fruity_Pebbles      110       1   1    135
    ## 31   31                           Golden_Crisp      100       2   0     45
    ## 32   32                         Golden_Grahams      110       1   1    280
    ## 33   33                      Grape_Nuts_Flakes      100       3   1    140
    ## 34   34                             Grape-Nuts      110       3   0    170
    ## 35   35                     Great_Grains_Pecan      120       3   3     75
    ## 36   36                       Honey_Graham_Ohs      120       1   2    220
    ## 37   37                     Honey_Nut_Cheerios      110       3   1    250
    ## 38   38                             Honey-comb      110       1   0    180
    ## 39   39            Just_Right_Crunchy__Nuggets      110       2   1    170
    ## 40   40                 Just_Right_Fruit_&_Nut      140       3   1    170
    ## 41   41                                    Kix      110       2   1    260
    ## 42   42                                   Life      100       4   2    150
    ## 43   43                           Lucky_Charms      110       2   1    180
    ## 44   44                                  Maypo      100       4   1      0
    ## 45   45       Muesli_Raisins,_Dates,_&_Almonds      150       4   3     95
    ## 46   46      Muesli_Raisins,_Peaches,_&_Pecans      150       4   3    150
    ## 47   47                   Mueslix_Crispy_Blend      160       3   2    150
    ## 48   48                   Multi-Grain_Cheerios      100       2   1    220
    ## 49   49                       Nut&Honey_Crunch      120       2   1    190
    ## 50   50              Nutri-Grain_Almond-Raisin      140       3   2    220
    ## 51   51                      Nutri-grain_Wheat       90       3   0    170
    ## 52   52                   Oatmeal_Raisin_Crisp      130       3   2    170
    ## 53   53                  Post_Nat._Raisin_Bran      120       3   1    200
    ## 54   54                             Product_19      100       3   0    320
    ## 55   55                            Puffed_Rice       50       1   0      0
    ## 56   56                           Puffed_Wheat       50       2   0      0
    ## 57   57                     Quaker_Oat_Squares      100       4   1    135
    ## 58   58                         Quaker_Oatmeal      100       5   2      0
    ## 59   59                            Raisin_Bran      120       3   1    210
    ## 60   60                        Raisin_Nut_Bran      100       3   2    140
    ## 61   61                         Raisin_Squares       90       2   0      0
    ## 62   62                              Rice_Chex      110       1   0    240
    ## 63   63                          Rice_Krispies      110       2   0    290
    ## 64   64                         Shredded_Wheat       80       2   0      0
    ## 65   65                 Shredded_Wheat_'n'Bran       90       3   0      0
    ## 66   66              Shredded_Wheat_spoon_size       90       3   0      0
    ## 67   67                                 Smacks      110       2   1     70
    ## 68   68                              Special_K      110       6   0    230
    ## 69   69                Strawberry_Fruit_Wheats       90       2   0     15
    ## 70   70                      Total_Corn_Flakes      110       2   1    200
    ## 71   71                      Total_Raisin_Bran      140       3   1    190
    ## 72   72                      Total_Whole_Grain      100       3   1    200
    ## 73   73                                Triples      110       2   1    250
    ## 74   74                                   Trix      110       1   1    140
    ## 75   75                             Wheat_Chex      100       3   1    230
    ## 76   76                               Wheaties      100       3   1    200
    ## 77   77                    Wheaties_Honey_Gold      110       2   1    200
    ##    fiber carbo sugars potass vitamins shelf weight cups   rating totalcarb
    ## 1   10.0   5.0      6    280       25     3   1.00 0.33 68.40297      11.0
    ## 2    2.0   8.0      8    135        0     3   1.00 1.00 33.98368      16.0
    ## 3    9.0   7.0      5    320       25     3   1.00 0.33 59.42551      12.0
    ## 4   14.0   8.0      0    330       25     3   1.00 0.50 93.70491       8.0
    ## 5    1.0  14.0      8     NA       25     3   1.00 0.75 34.38484      22.0
    ## 6    1.5  10.5     10     70       25     1   1.00 0.75 29.50954      20.5
    ## 7    1.0  11.0     14     30       25     2   1.00 1.00 33.17409      25.0
    ## 8    2.0  18.0      8    100       25     3   1.33 0.75 37.03856      26.0
    ## 9    4.0  15.0      6    125       25     1   1.00 0.67 49.12025      21.0
    ## 10   5.0  13.0      5    190       25     3   1.00 0.67 53.31381      18.0
    ## 11   0.0  12.0     12     35       25     2   1.00 0.75 18.04285      24.0
    ## 12   2.0  17.0      1    105       25     1   1.00 1.25 50.76500      18.0
    ## 13   0.0  13.0      9     45       25     2   1.00 0.75 19.82357      22.0
    ## 14   2.0  13.0      7    105       25     3   1.00 0.50 40.40021      20.0
    ## 15   0.0  12.0     13     55       25     2   1.00 1.00 22.73645      25.0
    ## 16   0.0  22.0      3     25       25     1   1.00 1.00 41.44502      25.0
    ## 17   1.0  21.0      2     35       25     1   1.00 1.00 45.86332      23.0
    ## 18   1.0  13.0     12     20       25     2   1.00 1.00 35.78279      25.0
    ## 19   0.0  12.0     13     65       25     2   1.00 1.00 22.39651      25.0
    ## 20   4.0  10.0      7    160       25     3   1.00 0.50 40.44877      17.0
    ## 21   1.0  21.0      0     NA        0     2   1.00 1.00 64.53382      21.0
    ## 22   1.0  21.0      3     30       25     3   1.00 1.00 46.89564      24.0
    ## 23   2.0  11.0     10    120       25     3   1.00 0.75 36.17620      21.0
    ## 24   1.0  18.0      5     80       25     3   1.00 0.75 44.33086      23.0
    ## 25   1.0  11.0     13     30       25     2   1.00 1.00 32.20758      24.0
    ## 26   1.0  14.0     11     25       25     1   1.00 0.75 31.43597      25.0
    ## 27   3.0  14.0      7    100       25     2   1.00 0.80 58.34514      21.0
    ## 28   5.0  12.0     10    200       25     3   1.25 0.67 40.91705      22.0
    ## 29   5.0  14.0     12    190       25     3   1.33 0.67 41.01549      26.0
    ## 30   0.0  13.0     12     25       25     2   1.00 0.75 28.02576      25.0
    ## 31   0.0  11.0     15     40       25     1   1.00 0.88 35.25244      26.0
    ## 32   0.0  15.0      9     45       25     2   1.00 0.75 23.80404      24.0
    ## 33   3.0  15.0      5     85       25     3   1.00 0.88 52.07690      20.0
    ## 34   3.0  17.0      3     90       25     3   1.00 0.25 53.37101      20.0
    ## 35   3.0  13.0      4    100       25     3   1.00 0.33 45.81172      17.0
    ## 36   1.0  12.0     11     45       25     2   1.00 1.00 21.87129      23.0
    ## 37   1.5  11.5     10     90       25     1   1.00 0.75 31.07222      21.5
    ## 38   0.0  14.0     11     35       25     1   1.00 1.33 28.74241      25.0
    ## 39   1.0  17.0      6     60      100     3   1.00 1.00 36.52368      23.0
    ## 40   2.0  20.0      9     95      100     3   1.30 0.75 36.47151      29.0
    ## 41   0.0  21.0      3     40       25     2   1.00 1.50 39.24111      24.0
    ## 42   2.0  12.0      6     95       25     2   1.00 0.67 45.32807      18.0
    ## 43   0.0  12.0     12     55       25     2   1.00 1.00 26.73451      24.0
    ## 44   0.0  16.0      3     95       25     2   1.00 1.00 54.85092      19.0
    ## 45   3.0  16.0     11    170       25     3   1.00 1.00 37.13686      27.0
    ## 46   3.0  16.0     11    170       25     3   1.00 1.00 34.13976      27.0
    ## 47   3.0  17.0     13    160       25     3   1.50 0.67 30.31335      30.0
    ## 48   2.0  15.0      6     90       25     1   1.00 1.00 40.10596      21.0
    ## 49   0.0  15.0      9     40       25     2   1.00 0.67 29.92429      24.0
    ## 50   3.0  21.0      7    130       25     3   1.33 0.67 40.69232      28.0
    ## 51   3.0  18.0      2     90       25     3   1.00 1.00 59.64284      20.0
    ## 52   1.5  13.5     10    120       25     3   1.25 0.50 30.45084      23.5
    ## 53   6.0  11.0     14    260       25     3   1.33 0.67 37.84059      25.0
    ## 54   1.0  20.0      3     45      100     3   1.00 1.00 41.50354      23.0
    ## 55   0.0  13.0      0     15        0     3   0.50 1.00 60.75611      13.0
    ## 56   1.0  10.0      0     50        0     3   0.50 1.00 63.00565      10.0
    ## 57   2.0  14.0      6    110       25     3   1.00 0.50 49.51187      20.0
    ## 58   2.7    NA     NA    110        0     1   1.00 0.67 50.82839        NA
    ## 59   5.0  14.0     12    240       25     2   1.33 0.75 39.25920      26.0
    ## 60   2.5  10.5      8    140       25     3   1.00 0.50 39.70340      18.5
    ## 61   2.0  15.0      6    110       25     3   1.00 0.50 55.33314      21.0
    ## 62   0.0  23.0      2     30       25     1   1.00 1.13 41.99893      25.0
    ## 63   0.0  22.0      3     35       25     1   1.00 1.00 40.56016      25.0
    ## 64   3.0  16.0      0     95        0     1   0.83 1.00 68.23588      16.0
    ## 65   4.0  19.0      0    140        0     1   1.00 0.67 74.47295      19.0
    ## 66   3.0  20.0      0    120        0     1   1.00 0.67 72.80179      20.0
    ## 67   1.0   9.0     15     40       25     2   1.00 0.75 31.23005      24.0
    ## 68   1.0  16.0      3     55       25     1   1.00 1.00 53.13132      19.0
    ## 69   3.0  15.0      5     90       25     2   1.00 1.00 59.36399      20.0
    ## 70   0.0  21.0      3     35      100     3   1.00 1.00 38.83975      24.0
    ## 71   4.0  15.0     14    230      100     3   1.50 1.00 28.59278      29.0
    ## 72   3.0  16.0      3    110      100     3   1.00 1.00 46.65884      19.0
    ## 73   0.0  21.0      3     60       25     3   1.00 0.75 39.10617      24.0
    ## 74   0.0  13.0     12     25       25     2   1.00 1.00 27.75330      25.0
    ## 75   3.0  17.0      3    115       25     1   1.00 0.67 49.78744      20.0
    ## 76   3.0  17.0      3    110       25     1   1.00 1.00 51.59219      20.0
    ## 77   1.0  16.0      8     60       25     1   1.00 0.75 36.18756      24.0

``` r
# Alternatively, with the tidyverse operations
Cereal <- Cereal %>% 
  mutate(totalcarb = carbo + sugars)
```

3.  How many cereals in the dataframe are from Shelf 2?

``` r
# use subset and length functions
length(subset(Cereal, shelf == 2))
```

    ## [1] 16

``` r
# Alternatively 
Cereal %>% 
  filter(shelf == 2) %>% 
  length()
```

    ## [1] 16

4.  How many unique shelves are included in the dataset?

``` r
length(unique(Cereal$shelf))
```

    ## [1] 3

5.  Take a subset of the dataframe with only the shelf 1

``` r
subset(Cereal, shelf == 1)
```

    ## # A tibble: 20 × 16
    ##     ...1 name     calor…¹ protein   fat sodium fiber carbo sugars potass vitam…²
    ##    <dbl> <chr>      <dbl>   <dbl> <dbl>  <dbl> <dbl> <dbl>  <dbl>  <dbl>   <dbl>
    ##  1     6 Apple_C…     110       2     2    180   1.5  10.5     10     70      25
    ##  2     9 Bran_Ch…      90       2     1    200   4    15        6    125      25
    ##  3    12 Cheerios     110       6     2    290   2    17        1    105      25
    ##  4    16 Corn_Ch…     110       2     0    280   0    22        3     25      25
    ##  5    17 Corn_Fl…     100       2     0    290   1    21        2     35      25
    ##  6    26 Frosted…     110       1     0    200   1    14       11     25      25
    ##  7    31 Golden_…     100       2     0     45   0    11       15     40      25
    ##  8    37 Honey_N…     110       3     1    250   1.5  11.5     10     90      25
    ##  9    38 Honey-c…     110       1     0    180   0    14       11     35      25
    ## 10    48 Multi-G…     100       2     1    220   2    15        6     90      25
    ## 11    58 Quaker_…     100       5     2      0   2.7  NA       NA    110       0
    ## 12    62 Rice_Ch…     110       1     0    240   0    23        2     30      25
    ## 13    63 Rice_Kr…     110       2     0    290   0    22        3     35      25
    ## 14    64 Shredde…      80       2     0      0   3    16        0     95       0
    ## 15    65 Shredde…      90       3     0      0   4    19        0    140       0
    ## 16    66 Shredde…      90       3     0      0   3    20        0    120       0
    ## 17    68 Special…     110       6     0    230   1    16        3     55      25
    ## 18    75 Wheat_C…     100       3     1    230   3    17        3    115      25
    ## 19    76 Wheaties     100       3     1    200   3    17        3    110      25
    ## 20    77 Wheatie…     110       2     1    200   1    16        8     60      25
    ## # … with 5 more variables: shelf <dbl>, weight <dbl>, cups <dbl>, rating <dbl>,
    ## #   totalcarb <dbl>, and abbreviated variable names ¹​calories, ²​vitamins

``` r
# Alternatively 
Cereal %>% 
  filter(shelf == 1)
```

    ## # A tibble: 20 × 16
    ##     ...1 name     calor…¹ protein   fat sodium fiber carbo sugars potass vitam…²
    ##    <dbl> <chr>      <dbl>   <dbl> <dbl>  <dbl> <dbl> <dbl>  <dbl>  <dbl>   <dbl>
    ##  1     6 Apple_C…     110       2     2    180   1.5  10.5     10     70      25
    ##  2     9 Bran_Ch…      90       2     1    200   4    15        6    125      25
    ##  3    12 Cheerios     110       6     2    290   2    17        1    105      25
    ##  4    16 Corn_Ch…     110       2     0    280   0    22        3     25      25
    ##  5    17 Corn_Fl…     100       2     0    290   1    21        2     35      25
    ##  6    26 Frosted…     110       1     0    200   1    14       11     25      25
    ##  7    31 Golden_…     100       2     0     45   0    11       15     40      25
    ##  8    37 Honey_N…     110       3     1    250   1.5  11.5     10     90      25
    ##  9    38 Honey-c…     110       1     0    180   0    14       11     35      25
    ## 10    48 Multi-G…     100       2     1    220   2    15        6     90      25
    ## 11    58 Quaker_…     100       5     2      0   2.7  NA       NA    110       0
    ## 12    62 Rice_Ch…     110       1     0    240   0    23        2     30      25
    ## 13    63 Rice_Kr…     110       2     0    290   0    22        3     35      25
    ## 14    64 Shredde…      80       2     0      0   3    16        0     95       0
    ## 15    65 Shredde…      90       3     0      0   4    19        0    140       0
    ## 16    66 Shredde…      90       3     0      0   3    20        0    120       0
    ## 17    68 Special…     110       6     0    230   1    16        3     55      25
    ## 18    75 Wheat_C…     100       3     1    230   3    17        3    115      25
    ## 19    76 Wheaties     100       3     1    200   3    17        3    110      25
    ## 20    77 Wheatie…     110       2     1    200   1    16        8     60      25
    ## # … with 5 more variables: shelf <dbl>, weight <dbl>, cups <dbl>, rating <dbl>,
    ## #   totalcarb <dbl>, and abbreviated variable names ¹​calories, ²​vitamins

6.  Take a subset of the dataframe of all cereals that have less than 70
    calories, AND have more than 20 units of vitamins.

``` r
subset(Cereal, calories < 70 & vitamins > 20)
```

    ## # A tibble: 1 × 16
    ##    ...1 name      calor…¹ protein   fat sodium fiber carbo sugars potass vitam…²
    ##   <dbl> <chr>       <dbl>   <dbl> <dbl>  <dbl> <dbl> <dbl>  <dbl>  <dbl>   <dbl>
    ## 1     4 All-Bran…      50       4     0    140    14     8      0    330      25
    ## # … with 5 more variables: shelf <dbl>, weight <dbl>, cups <dbl>, rating <dbl>,
    ## #   totalcarb <dbl>, and abbreviated variable names ¹​calories, ²​vitamins

``` r
# Alternatively 
Cereal %>% 
  filter(calories <70 & vitamins >20)
```

    ## # A tibble: 1 × 16
    ##    ...1 name      calor…¹ protein   fat sodium fiber carbo sugars potass vitam…²
    ##   <dbl> <chr>       <dbl>   <dbl> <dbl>  <dbl> <dbl> <dbl>  <dbl>  <dbl>   <dbl>
    ## 1     4 All-Bran…      50       4     0    140    14     8      0    330      25
    ## # … with 5 more variables: shelf <dbl>, weight <dbl>, cups <dbl>, rating <dbl>,
    ## #   totalcarb <dbl>, and abbreviated variable names ¹​calories, ²​vitamins

7.  Take a subset of the dataframe containing cereals that contain at
    least 10 units of sugar, and keep only the variables `name`,
    `calories` and `vitamins`. Then inspect the 1rst 5 rows of the
    dataframe with head.

``` r
subset(Cereal, sugars >= 10,
       select = c("name", "calories", "vitamins")) %>% head(5)
```

    ## # A tibble: 5 × 3
    ##   name                    calories vitamins
    ##   <chr>                      <dbl>    <dbl>
    ## 1 Apple_Cinnamon_Cheerios      110       25
    ## 2 Apple_Jacks                  110       25
    ## 3 Cap'n'Crunch                 120       25
    ## 4 Cocoa_Puffs                  110       25
    ## 5 Corn_Pops                    110       25

``` r
# Alternatively 
Cereal %>% 
  filter(sugars >= 10) %>% 
  select(name,calories, vitamins) %>% 
  head(5)
```

    ## # A tibble: 5 × 3
    ##   name                    calories vitamins
    ##   <chr>                      <dbl>    <dbl>
    ## 1 Apple_Cinnamon_Cheerios      110       25
    ## 2 Apple_Jacks                  110       25
    ## 3 Cap'n'Crunch                 120       25
    ## 4 Cocoa_Puffs                  110       25
    ## 5 Corn_Pops                    110       25

``` r
# Alternatively, using indexing
# we pass the rows we want to filter as the first argument and columns as the second
Cereal[Cereal$sugars >=10, c("name", "calories", "vitamins")] %>% head(5)
```

    ## # A tibble: 5 × 3
    ##   name                    calories vitamins
    ##   <chr>                      <dbl>    <dbl>
    ## 1 Apple_Cinnamon_Cheerios      110       25
    ## 2 Apple_Jacks                  110       25
    ## 3 Cap'n'Crunch                 120       25
    ## 4 Cocoa_Puffs                  110       25
    ## 5 Corn_Pops                    110       25

8.  For one of the above subsets, write a new CSV 1le to disk

``` r
# create subset
Cereal_sub <- Cereal %>% 
  filter(sugars >= 10) %>% 
  select(name,calories, vitamins)

# save to working directory
write.csv(Cereal_sub, "Cereal_sub.csv", row.names = F)
```

9.  Rename the column `potass` to `potassium`

``` r
# using rename function from dplyr
Cereal %>% 
  rename("potassium" = "potass") %>% 
  head(2)
```

    ## # A tibble: 2 × 16
    ##    ...1 name     calor…¹ protein   fat sodium fiber carbo sugars potas…² vitam…³
    ##   <dbl> <chr>      <dbl>   <dbl> <dbl>  <dbl> <dbl> <dbl>  <dbl>   <dbl>   <dbl>
    ## 1     1 100%_Br…      70       4     1    130    10     5      6     280      25
    ## 2     2 100%_Na…     120       3     5     15     2     8      8     135       0
    ## # … with 5 more variables: shelf <dbl>, weight <dbl>, cups <dbl>, rating <dbl>,
    ## #   totalcarb <dbl>, and abbreviated variable names ¹​calories, ²​potassium,
    ## #   ³​vitamins

*we can also apply the indexing method to rename variables as follows:*
`colnames(Cereal)[colnames(Cereal) == "potass"] <- "potassium"`

### Working with short dataset

1.  Read the following sales data into R Day, sales sunday, 3 monday, 2
    tuesday, 5 wednesday, 0 thursday, 8 friday, 1 saturday, 2

``` r
sales <- read.csv(text = "Day, sales
sunday, 3
monday, 2
tuesday, 5
wednesday, 0
thursday, 8
friday, 1
saturday, 2")
```

2.  Add a day number to the dataset you read (1) in above

``` r
sales$day_number <- 1:7
sales
```

    ##         Day sales day_number
    ## 1    sunday     3          1
    ## 2    monday     2          2
    ## 3   tuesday     5          3
    ## 4 wednesday     0          4
    ## 5  thursday     8          5
    ## 6    friday     1          6
    ## 7  saturday     2          7

``` r
# Alternatively 
sales %>% 
  mutate(day_number = 1:7)
```

    ##         Day sales day_number
    ## 1    sunday     3          1
    ## 2    monday     2          2
    ## 3   tuesday     5          3
    ## 4 wednesday     0          4
    ## 5  thursday     8          5
    ## 6    friday     1          6
    ## 7  saturday     2          7

3.  Delete the `Day` variable

``` r
sales %>% 
  select(-Day)
```

    ##   sales day_number
    ## 1     3          1
    ## 2     2          2
    ## 3     5          3
    ## 4     0          4
    ## 5     8          5
    ## 6     1          6
    ## 7     2          7

``` r
# Alternatively
sales[,-1]
```

    ##   sales day_number
    ## 1     3          1
    ## 2     2          2
    ## 3     5          3
    ## 4     0          4
    ## 5     8          5
    ## 6     1          6
    ## 7     2          7

4.  On which day do we observe the most sales

``` r
sales$Day[which.max(sales$sales)]
```

    ## [1] "thursday"

5.  On which day do we observe the least sales

``` r
sales$Day[which.min(sales$sales)]
```

    ## [1] "wednesday"

6.  Sort the dataset by number of sales seen.

``` r
# sort in increasing order
sales %>% 
  arrange(sales)
```

    ##         Day sales day_number
    ## 1 wednesday     0          4
    ## 2    friday     1          6
    ## 3    monday     2          2
    ## 4  saturday     2          7
    ## 5    sunday     3          1
    ## 6   tuesday     5          3
    ## 7  thursday     8          5

``` r
# sort in decreasing order
sales %>% 
  arrange(-sales)
```

    ##         Day sales day_number
    ## 1  thursday     8          5
    ## 2   tuesday     5          3
    ## 3    sunday     3          1
    ## 4    monday     2          2
    ## 5  saturday     2          7
    ## 6    friday     1          6
    ## 7 wednesday     0          4
