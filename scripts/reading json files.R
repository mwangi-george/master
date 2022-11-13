essential_libraries()

library(rjson)
library(jsonlite)
iris <- fromJSON(file = "datasets/iris.json")


# if the named list contain equal lengths, use
# unnest_wider otherwise unnest_longer
tibble(character = iris) %>% 
  unnest_wider(character) %>% view()


season1 <- fromJSON(file = "datasets/got/season1.json")

tibble(character = season1) %>% 
  unnest_longer(character) %>% 
  mutate(character_id = as.numeric(character_id)) %>% 
  group_by(character_id) %>% 
  nest() %>% 
  unnest_wider(data) 



# Load the jsonlite package
library(jsonlite)

# wine_json is a JSON
wine_json <- '{"name":"Chateau Migraine", "year":1997, "alcohol_pct":12.4, "color":"red", "awarded":false}'

# Convert wine_json into a list: wine
wine <- fromJSON(wine_json)

# Print structure of wine
str(wine)


# jsonlite is preloaded

# Definition of quandl_url
quandl_url <- "https://www.quandl.com/api/v3/datasets/WIKI/FB/data.json?auth_token=i83asDsiWUUyfoypkgMz"

# Import Quandl data: quandl_data
quandl_data <- fromJSON(quandl_url)

# Print structure of quandl_data
str(quandl_data)



hunter_killer <- '{"Title":"Hunter Killer","Year":"2018","Rated":"R","Released":"26 Oct 2018","Runtime":"121 min","Genre":"Action, Thriller","Director":"Donovan Marsh","Writer":"Arne Schmidt, Jamie Moss, George Wallace","Actors":"Gerard Butler, Gary Oldman, Common","Plot":"An untested American submarine captain teams with U.S. Navy Seals to rescue the Russian president, who has been kidnapped by a rogue general.","Language":"English, Russian","Country":"United Kingdom, China, France, United States","Awards":"1 win","Poster":"https://m.media-amazon.com/images/M/MV5BYjRkNzQ0NmYtZmQyMS00Yzk5LWEzZjQtYzhlOTRlMzVjMzA3XkEyXkFqcGdeQXVyMjM4NTM5NDY@._V1_SX300.jpg","Ratings":[{"Source":"Internet Movie Database","Value":"6.6/10"},{"Source":"Rotten Tomatoes","Value":"37%"},{"Source":"Metacritic","Value":"43/100"}],"Metascore":"43","imdbRating":"6.6","imdbVotes":"63,629","imdbID":"tt1846589","Type":"movie","DVD":"15 Jan 2019","BoxOffice":"$15,767,460","Production":"N/A","Website":"N/A","Response":"True"}'


movie <- fromJSON(hunter_killer)

# The package jsonlite is already loaded

# Definition of the URLs
url_sw4 <- "http://www.omdbapi.com/?apikey=72bc447a&i=tt0076759&r=json"
url_sw3 <- "http://www.omdbapi.com/?apikey=72bc447a&i=tt0121766&r=json"

# Import two URLs with fromJSON(): sw4 and sw3
sw4 <- fromJSON(url_sw4)
sw3 <- fromJSON(url_sw3)

# Print out the Title element of both lists
sw4$Title
sw3$Title

# Is the release year of sw4 later than sw3?

sw4$Year > sw3$Year


x <- '[2,3,"me", true, false,3,100]'
x1 <- fromJSON(x)
str(x1)

meta <- toJSON(metadata)
str(meta)
view(meta)

# jsonlite is already loaded

# Challenge 1
json1 <- '[[1, 2], [3, 4]]'
fromJSON(json1)

# Challenge 2
json2 <- '[{"a": 1, "b": 2}, {"a": 3, "b": 4}, {"a": 5, "b":6}]'
fromJSON(json2)



# URL pointing to the .csv file
url_csv <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/water.csv"

# Import the .csv file located at url_csv
water <- read.csv(url_csv, stringsAsFactors = F)

# Convert the data file according to the requirements
water_json <- toJSON(water)

# Print out water_json
water_json

# Minify and prettify
# JSONs can come in different formats. Take these two JSONs, that are in fact exactly the same: 
# the first one is in a minified format, the second one is in a pretty format with indentation, whitespace and new lines:
  
  # Mini
  '{"a":1,"b":2,"c":{"x":5,"y":6}}'

# Pretty
'{
  "a": 1,
  "b": 2,
  "c": {
    "x": 5,
    "y": 6
  }
}'
 
# Unless you're a computer, you surely prefer the second version. 
# However, the standard form that toJSON() returns, is the minified version, 
# as it is more concise. You can adapt this behavior by setting the pretty argument inside toJSON() to TRUE. 
# If you already have a JSON string, you can use prettify() or minify() to make the JSON pretty or as concise as possible.

  # jsonlite is already loaded
  
  # Convert mtcars to a pretty JSON: pretty_json
  pretty_json <- toJSON(mtcars, pretty = T)
  
  # Print pretty_json
  pretty_json
  
  # Minify pretty_json: mini_json
  mini_json <- minify(pretty_json)
  
  # Print mini_json
  mini_json

  # back to pretty format
prettify(mini_json)










