#-----------Perform simple random sampling to get 0.25 of the population
attrition_srs <- attrition_pop%>%
  slice_sample(prop =0.25)



#-------Perform stratified sampling to get 0.25 of each relationship group
attrition_strat <- attrition_pop %>%
  group_by(RelationshipSatisfaction) %>%
  slice_sample(prop = 0.25)%>%
  ungroup()




##--------cluster sampling---------------##
# Get unique values of RelationshipSatisfaction
satisfaction_unique <- unique(attrition_pop$RelationshipSatisfaction)

# Randomly sample for 2 of the unique satisfaction values
satisfaction_samp <- sample(satisfaction_unique, 2)

# Perform cluster sampling on the selected group getting 0.25 of the population
attrition_clust <- attrition_pop %>%
  filter(RelationshipSatisfaction %in% satisfaction_samp)%>%
  group_by(RelationshipSatisfaction)%>%
  slice_sample(n = nrow(attrition_pop)/4)%>%
  ungroup()


##------------Comparing summary statistics-------------##
# Use the whole population dataset 
mean_attrition_pop <- attrition_pop %>% 
  # Group by relationship satisfaction level
  group_by(RelationshipSatisfaction) %>% 
  # Calculate the proportion of employee attrition
  summarize(mean_attrition = mean(Attrition == "Yes"))

# See the result
mean_attrition_pop


# Calculate the same thing for the simple random sample 
mean_attrition_srs <-  attrition_srs %>%
  group_by(RelationshipSatisfaction) %>% 
  # Calculate the proportion of employee attrition
  summarize(mean_attrition = mean(Attrition == "Yes"))

# See the result
mean_attrition_srs


# Calculate the same thing for the stratified sample 
mean_attrition_strat <- attrition_strat %>%
  group_by(RelationshipSatisfaction) %>% 
  # Calculate the proportion of employee attrition
  summarize(mean_attrition = mean(Attrition == "Yes"))

# See the result
mean_attrition_strat


# Calculate the same thing for the cluster sample 
mean_attrition_clust <- attrition_clust %>%
  group_by(RelationshipSatisfaction) %>% 
  # Calculate the proportion of employee attrition
  summarize(mean_attrition = mean(Attrition == "Yes"))

# See the result
mean_attrition_clust
