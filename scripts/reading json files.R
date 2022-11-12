essential_libraries()

library(rjson)
iris <- fromJSON(file = "datasets/iris.json")

tibble(character = iris) %>% 
  unnest_wider(character) %>% view()


season1 <- fromJSON(file = "datasets/got/season1.json")

tibble(character = season1) %>% 
  unnest_longer(character) %>% 
  mutate(character_id = as.numeric(character_id)) %>% 
  group_by(character_id) %>% 
  nest() %>% 
  unnest_wider(data) 
