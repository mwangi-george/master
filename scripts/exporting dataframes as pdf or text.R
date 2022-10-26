# # exporting dataframes as pdf or text -----------------------------------


install.packages("gridExtra") # for pdf
install.packages("stargazer") # for text

library(stargazer)
library(gridExtra)

# create dataframe for test
data <- data.frame(var1 = 1:5,
                   var2 = LETTERS[1:5],
                   var3 = 3,
                   var4 = c("Hey", "there", "I'm", "using", "WhatsApp"))

# export the data frame as pdf, run these 3 lines together!
pdf("data_gridExtra.pdf")
grid.table(data)
dev.off()
#dataframe will be saved as a pdf in the working directory


# export as text
stargazer(data,
          summary = F,
          type = "text",
          out = "data_text.txt")

