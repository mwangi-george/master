
# separating columns into several variables -------------------------------

# separate the initials column and overwrite to the fam_info
fam_info <- fam_info %>% 
  select(-12) %>% 
  separate(Initial, into = c("first_initial", "last_sir_initial"), 
           sep = "\\.") %>% 
  separate(last_sir_initial, into = c("last_initial", "sir_initial"), sep = "-") %>% 
  view()

# we may want to put the initials back together   
fam_info <- fam_info %>% 
  mutate(initial = paste(first_initial, ".", last_initial, "-", sir_initial)) %>% 
  select(-c("first_initial", "last_initial", "sir_initial")) %>% 
  view()
