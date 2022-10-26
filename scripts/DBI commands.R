library(DBI)
library(RSQLite)
lite_connect <- dbConnect(SQLite(), "learningSQL/SQl.sqlite")
dbListTables(lite_connect)
dbWriteTable(lite_connect, "datarium_marketing", marketing)
dbRemoveTable(lite_connect, "fam_edu")

dbReadTable(lite_connect, "fam_info")

dbSendQuery(lite_connect, "alter table fam_info drop column preferred_hand")

dbSendQuery(conn = lite_connect, 
            statement = "alter table fam_info add preferred_hand VARCHAR(30) NOT NULL")

dbSendQuery(conn = lite_connect,statement = "insert into fam_info (preferred_hand) 
            values ('left', 'right', 'right', 'left', 'right', 'right', 'right')")

dbSendQuery(conn = lite_connect, 
            statement = "INSERT INTO fam_info 
            (id, first_name, last_name, age, gender,
            education, body_height_cm, body_weight_kg, shoe_size, marital_status)
            values (8, 'Alvin', 'Njau', 6/12, 'Male', 'None', 50, 10, 15, 'single')")

ms_connect <- dbConnect(odbc::odbc(), "SQLSERVER_DSN")

dbSendQuery(conn = ms_connect, "use record_company")

dbGetQuery(conn = ms_connect, 
           statement = "SELECT * FROM bands")

dbGetQuery(conn = ms_connect, 
           statement = "SELECT * FROM albums")

height_weight <- dbGetQuery(conn = lite_connect, 
                            statement = "SELECT education, body_height_cm, body_weight_kg FROM fam_info") #%>% 


cor(body_height_cm, body_weight_kg, method = "kendall")

attach(height_weight)

aov(education ~ body_height_cm, data = height_weight)

t_test <- iris %>% 
  select(Species, Sepal.Length) %>% 
  group_by(Species) %>% 
  summarise(mean_sepal_length = mean(Sepal.Length)) %>% 
  view()
summary(iris$Sepal.Length)  
attach(t_test)

aov(mean_sepal_length ~ Species, data = t_test) 
dbDisconnect(lite_connect)
dbDisconnect(ms_connect)

install.packages("RODBC")
install.packages("odbc")
install.packages("DBI")

library(DBI)
library(RODBC)
library(odbc)
library(RSQLite) #important to run db_commands

ms_connect <- dbConnect(odbc::odbc(), "SQLServer_DSN") # connects to ms sql server 
lite_connect <- dbConnect(SQLite(), "learningSQL/SQL.sqlite") # connects to the SQLite local DB
dbDisconnect(ms_connect) 
dbDisconnect(lite_connect)




dbConnect(SQLite(), "learningSQL/SQL.sqlite")

fam_info <- dbGetQuery(dbConnect(SQLite(), "learningSQL/SQL.sqlite"), 
                       "select * from fam_info")

dbGetQuery(dbConnect(SQLite(), "learningSQL/SQL.sqlite"), 
           "delete from fam_info where id = 7")

dbExecute(dbConnect(SQLite(), "learningSQL/SQL.sqlite"), 
          "insert into fam_info(id, first_name, last_name, age, gender, education,
          body_height_cm, body_weight_kg, shoe_size, marital_status)
          values (7, 'Anastacia', 'Wairimu', 5, 'Female', 'Lower Primary', 80, 30, 20, 'single')")

dbExecute(dbConnect(SQLite(), "learningSQL/SQL.sqlite"), 
          "alter table fam_info delete preferred")

dbListFields(dbConnect(SQLite(), "learningSQL/SQL.sqlite"), "fam_info")

subset(fam_info,
       subset = body_height_cm >= 150 & marital_status=="married",
       select = c("first_name", "marital_status"))

