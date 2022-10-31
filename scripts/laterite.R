
# Written by: Mwangi George
# Written on: 2022-10-30
# Description: script file for laterite mobile money data 



# load important libraries
pacman::p_load(tidyverse, janitor, data.table, ggthemes, infer)

# load the data
laterite <- fread("D:\\Excel learning\\PROJECT_1\\laterite_mobilemoney_data.csv")

# deselect start_time and end_time
laterite <- laterite %>% 
  select(-ends_with("time"))

# format the data 
laterite %>% 
  # selecting variables to format
  select(1:3) %>% 
  # restructure from long to wide format
  pivot_wider(names_from = account_num,
              values_from = account_type) %>% 
  # rename variables 
  rename(account_num1 = `1`,
         account_num2 = `2`,
         account_num3 =`3`,
         account_num4 = `4`,
         account_num5 = `5`) -> accounts

# format and create new table(mobile_money)
mobile_money <- laterite %>% 
  # deselect fields in account tables
  select(-c("account_num", "account_type")) %>% 
  # remove the duplication
  filter(!duplicated(.)) %>% 
  # inner join with the accounts table 
  inner_join(accounts, by = "hhid") %>%
  # Select the order of variables 
  select(hhid, starts_with("account_num"), everything())
  
mobile_money %>% 
  filter(account_num1 == "Mobile Money" | account_num2 == "Mobile Money") %>% 
  view()

mobile_money %>% 
  distinct(account_num5)


# create dummy for financial exclusion
mobile_money <- mobile_money %>%
  # create new variable 
  mutate(finacially_excluded = if_else(account_num1 == "None", 1, 0))

# rename the created column  
mobile_money <- mobile_money %>% 
  rename(financially_excluded = finacially_excluded)


# create dummy for financial inclusion,
# NA's create unexpected results hence use of case when
mobile_money <- mobile_money %>% 
  # create new variable,
  mutate(digitally_financially_included = case_when(
    mobile_money$account_num1 == "Mobile Money" ~ 1,
    mobile_money$account_num3 == "Online Bank Account" ~ 1,
    TRUE ~ 0
  ))

# overall rate of financial exclusion
financial_exclusion_summary <- mobile_money %>% 
  # filter for rows that satisfy financial exclusion
  filter(financially_excluded == 1) %>% 
  # group results by districts
  group_by(district) %>% 
  # summarize for desired results 
  summarise(financially_excluded_total = sum(financially_excluded)) %>% 
  # create new variable rate, percent of financial exclusion
  mutate(financial_exclusion_rate = 100 * 
           financially_excluded_total/sum(financially_excluded_total),
         # add percent sign to this rate 
         financial_exclusion_rate = paste(financial_exclusion_rate, "%"))

# overall rate of digital financial inclusion
digital_financial_summary <- mobile_money %>% 
  # filter for digital financial inclusion
  filter(digitally_financially_included == 1) %>% 
  # groub results by district
  group_by(district) %>% 
  # summarize for desired results 
  summarise(total_digital_financial_inclusion = sum(digitally_financially_included)) %>% 
  # create digital financial rate column
  mutate(digital_financial_inclusion_rate = 100 * 
           total_digital_financial_inclusion/sum(total_digital_financial_inclusion),
         # add percent sign
         digital_financial_inclusion_rate = paste(digital_financial_inclusion_rate, "%"))


  
company_mobile <- mobile_money %>% 
  filter(mm_account_telco_main == "Company_A" |
           mm_account_telco_main == "Company_B" |
           mm_account_telco_main == "Company_C") %>% 
  group_by(mm_account_telco_main) %>% 
  count(account_num1) %>% ungroup() %>% 
  mutate(percent = 100*n/sum(n))


# visualize the above results 
company_mobile %>% 
  ggplot(aes(mm_account_telco_main, percent, fill = mm_account_telco_main))+
  geom_col()+
  labs(title = "Market Share of Mobile Money Providers",
       x = "Mobile Money Provider",
       y = "Percentage of Market Share")+
  theme_economist()+
  theme(legend.position = "none")

#v240
test <- mobile_money %>% 
  filter(v240 == "yes" | v240 == "no") %>% view()



test %>% 
  prop_test(
    v240 ~ urban,
    order = c("Urban", "Rural"),
    success = "yes",
    alternative = "two.sided",
    correct = F
    )



mobile_money %>% 
  count(mm_account_cancelled, agent_trust)

mobile_money %>% 
  filter(mm_account_cancelled == "yes") %>% 
  filter(agent_trust == "yes" | agent_trust == "no") %>% 
  count(mm_account_cancelled, agent_trust)


mobile_money %>% 
  count(mm_account_cancelled, urban)

mobile_money %>% 
  count(mm_account_cancelled, v240)

mobile_money %>% 
  count(mm_account_cancelled, prefer_cash)

mobile_money %>% 
  count(mm_account_cancelled, gender)
