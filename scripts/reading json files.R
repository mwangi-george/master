essential_libraries()

library(rjson)
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
