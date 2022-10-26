# Use the suffix argument to replace .x and .y suffixes
parts %>% 
  inner_join(part_categories, by = c("part_cat_id" = "id"), suffix = c("_part", 
                                                                       "_category"))

# Combine the parts and inventory_parts tables
parts %>%
  inner_join(inventory_parts, by = "part_num")


sets %>%
  # Add inventories using an inner join 
  inner_join(inventories, by = "set_num") %>%
  # Add inventory_parts using an inner join 
  inner_join(inventory_parts, by = c("id" = "inventory_id"))


# Count the number of colors and sort
#sets %>%
 # inner_join(inventories, by = "set_num") %>%
  #inner_join(inventory_parts, by = c("id" = "inventory_id")) %>%
  #inner_join(colors, by = c("color_id" = "id"), suffix = c("_set", "_color")) %>%
  #count(name_color, sort = T)

# Combine the star_destroyer and millennium_falcon tables
#millennium_falcon %>%
 # left_join(star_destroyer, by = c("part_num", "color_id"), 
  #          suffix = c("_falcon", "_star_destroyer"))



# Aggregate Millennium Falcon for the total quantity in each part
#millennium_falcon_colors <- millennium_falcon %>%
  #group_by(color_id) %>%
#  summarize(total_quantity = sum(quantity))

# Aggregate Star Destroyer for the total quantity in each part
#star_destroyer_colors <- star_destroyer %>%
 # group_by(color_id) %>%
  #summarize(total_quantity = sum(quantity))

# Left join the Millennium Falcon colors to the Star Destroyer colors
#millennium_falcon_colors %>%
 # left_join(star_destroyer_colors, by = "color_id", suffix = c("_falcon","_star_destroyer"))


inventory_version_1 <- inventories %>%
  filter(version == 1)

# Join versions to sets
sets %>%
  left_join(inventory_version_1, by = "set_num") %>%
  # Filter for where version is na
  filter(is.na(version))


parts %>%
  count(part_cat_id) %>%
  right_join(part_categories, by = c("part_cat_id" = "id")) %>%
  # Filter for NA
  filter(is.na(n))


parts %>%
  count(part_cat_id) %>%
  right_join(part_categories, by = c("part_cat_id" = "id")) %>%
  # Use replace_na to replace missing values in the n column
  replace_na(list(n = 0))


themes %>% 
  # Inner join the themes table
  inner_join(themes, by = c("id" = "parent_id"),
             suffix = c("_parent", "_child")) %>%
  # Filter for the "Harry Potter" parent name 
  filter(name_parent == "Harry Potter")

# Join themes to itself again to find the grandchild relationships
themes %>% 
  inner_join(themes, by = c("id" = "parent_id"), suffix = c("_parent", "_child")) %>%
  inner_join(themes, by = c("id_child" = "parent_id"), suffix = c("_parent", "_grandchild"))

themes %>% 
  # Left join the themes table to its own children
  left_join(themes, by = c("id" = "parent_id"), suffix = c("_parent", "_child")) %>%
  # Filter for themes that have no child themes
  filter(is.na(name_child))

pop
quantile(pop$males)
quantile(pop$males, probs = c(0, 0.2, 0.4, 0.6,0.8,1))
quantile(pop$males, seq(0,1,0.2))
attach(pop)

iqr <- quantile(males, 0.75) - quantile(males, 0.25)
lower_threshold <- quantile(males, 0.25) - 1.5*iqr
upper_threshold <- quantile(males, 0.75) + 1.5*iqr

pop %>% 
  filter(males < lower_threshold | males > upper_threshold)

set.seed(10)
pop %>% 
  sample_n(100, replace = T)

dice <- data.frame(face = 1:6, prob = 1/6)
ggplot(dice, aes(face))+
  geom_histogram(bins = 6, binwidth = 0.3)
mean(dice$face)


die <- data.frame(n= 1:6)
die %>% 
  ggplot(aes(n))+
  geom_histogram(bins = 6, binwidth = .9)

die %>% 
  sample_n(10, replace = T) %>% 
  ggplot(aes(n))+
  geom_histogram(bins = 10)+
  expand_limits(x=0)


pacman::p_load(tidyverse)

 iris %>% 
   ggplo





