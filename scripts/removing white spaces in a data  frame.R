# Written by: George Ngugi
# Written on: 2022-10-03
# Description: Removing white spaces in a data frame -----------------------------------


library(tidyverse)

# create dataframe
messydata <- data.frame(x1 = c(" a aa ", " bb b ", "   c  c c"),
                           x2 = c("x x  x", "   y yy ", "z z z  "))

# removing white spaces in the dataframe using gsub()
as.data.frame(apply(messydata, 
                    2,
                    function(x)
                    {
                      gsub("\\s+", "", x)
                    }
                    )
              ) %>%
  head()


# removing white spaces in the dataframe using gsub()
apply(messydata,
      2,                        #  specifies column operations rather than rows
      str_remove_all, " ") %>%  #finds a patterna and results in a clean vector 
  as.data.frame()               # to make the output a data frame 


# using lapply 
data.frame(lapply(messydata,
                  function(x)
                  {
                    gsub(x,
                        pattern = " ",
                        replacement = "")
                  }
                  )
           )


data.frame(lapply(white_spaces,
                  function(x)
                  {
                    str_replace_all(x,  # you can also use gsub()
                                   pattern = " ",
                                   replacement = "")
                  }
                  )
           ) 


