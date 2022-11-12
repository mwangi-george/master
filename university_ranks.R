universities <- read_csv("datasets/universities.csv")

names(universities)

universities %>% 
  filter(country == "United States of America") %>% 
  count()

times_data <- read_csv("datasets/times_data.csv")

glimpse(times_data)
head(universities)

distinct(times_data, world_rank) %>% view()

metadata <- tibble(as.tibble(names(times_data)))

metadata %>% 
  rename(variable = value) %>% 
  mutate(description =c("world rank for the university. Contains rank ranges and equal ranks (eg. =94 and 201-250)",
                        "name of university",
                        "country of each university",
                        "university score for teaching (the learning environment)",
                        "university score international outlook (staff, students, research)",
                        "university score for research (volume, income and reputation)",
                        "university score for citations (research influence)",
                        "university score for industry income (knowledge transfer)",
                        "total score for university, used to determine rank",
                        "number of students at the university",
                        "Number of students divided by number of staff",
                        "Percentage of students who are international",
                        "Female student to Male student ratio",
                        "year of the ranking (2011 to 2016 included)"
                        )) -> metadata

times_data %>% 
  rowid_to_column() -> times_data

times_data %>%
  mutate(
    international = as.numeric(international),
    income = as.numeric(income),
    total_score = as.numeric(total_score),
    international_students = str_remove_all(
      international_students,
      pattern = "%"
    ),
    international_students = as.numeric(international_students) / 100
  ) %>%
  separate(
    female_male_ratio,
    into = c("female_ratio", "male_ratio"),
    sep = " : "
  ) %>%
  mutate(
    female_ratio = as.numeric(female_ratio) / 100,
    male_ratio = as.numeric(male_ratio) / 100,
    n_female = floor(female_ratio * num_students),
    n_male = ceiling(male_ratio * num_students),
    n_international = floor(international_students * num_students),
    n_local = num_students - n_international,
    n_staff = round(num_students / student_staff_ratio),
    university_name = as.factor(university_name),
    country = as.factor(country),
    world_rank = str_remove_all(
      string = world_rank,
      pattern = "="
    ),
    world_rank = as.factor(world_rank)
  ) %>%
  select(
    rowid, year, world_rank:num_students, n_female:n_staff
  ) -> university_ranks






