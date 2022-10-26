# From previous steps
attrition_pop %>% 
  count(Education, sort = TRUE) %>% 
  mutate(percent = 100 * n / sum(n))

attrition_strat <- attrition_pop %>% 
  group_by(Education) %>% 
  slice_sample(prop = 0.4) %>% 
  ungroup()

# Get the counts and percents from attrition_strat
education_counts_strat <- attrition_strat %>%
  count(Education, sort = T)%>%
  mutate(percent = 100*n/sum(n))

# See the results
education_counts_strat

##----------------Equal counts stratified sampling---------------##

# If one subgroup is larger than another subgroup in the population, 
#but you don't want to reflect that difference in your analysis, 
#For example, if you are analyzing blood types, O is the most common blood type worldwide, 
#but you may wish to have equal amounts of O, A, B, and AB in your sample.

#Use equal counts stratified sampling on attrition_pop to get 30 employees from each Education group. 
#That is, group by Education and perform a simple random sample of size 30 on each group.
#Ungroup the stratified sample.

# From previous step
attrition_eq <- attrition_pop %>%
  group_by(Education) %>% 
  slice_sample(n = 30) %>%
  ungroup()

# Get the counts and percents from attrition_eq
education_counts_eq <- attrition_eq%>%
count(Education, sort = T)%>%
mutate(percent = 100*n/sum(n))

# See the results
education_counts_eq



##----------------------------Weighted sampling----------------------##

Stratified sampling provides rules about the probability of picking rows 
from your dataset at the subgroup level. A generalization of this is weighted sampling, 
which lets you specify rules about the probability of picking rows at the row level. 
The probability of picking any given row is proportional to the weight value for that row.

# Using attrition_pop, plot YearsAtCompany as a histogram with binwidth 1
attrition_pop %>%
ggplot(aes(YearsAtCompany))+
geom_histogram(binwidth = 1)

# Sample 400 employees weighted by YearsAtCompany
attrition_weight <- attrition_pop %>%
slice_sample(n = 400, weight_by = YearsAtCompany)

# See the results
attrition_weight

# Using attrition_weight, plot YearsAtCompany as a histogram with binwidth 1
attrition_weight %>%
ggplot(aes(YearsAtCompany))+
geom_histogram(binwidth = 1)




##-------------------Benefits of clustering-------------------####

Cluster sampling is two-stage sampling technique that is closely related to stratified sampling. 
First you randomly sample which subgroups to include in the sample, then for each subgroup 
you randomly sample rows within that group.

# Get unique JobRole values
job_roles_pop <- unique(attrition_pop$JobRole)

# Randomly sample four JobRole values
job_roles_samp <- sample(job_roles_pop, 4)

# See the result
job_roles_samp

# Filter for rows where JobRole is in job_roles_samp
attrition_filtered <- attrition_pop %>%
filter(JobRole %in% job_roles_samp)


# Randomly sample 10 employees from each sampled job role
attrition_clus <- attrition_filtered %>%
group_by(JobRole)%>%
slice_sample(n = 10)

# See the result
attrition_clus