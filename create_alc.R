#Minttu Lindholm 14.11.2019
#Data wrangling 
#Logistic regression

student_math <- read.csv("student-math.csv", sep = ";", header = TRUE)
student_por <- read.table("student-por.csv", sep = ";", header = TRUE)

str(student_math)
str(student_por)
dim(student_math)
dim(student_por)

# student_math includes 395 observations and 33 variables. 
# student_por includes 649 observations and 33 variables.

#Joining the two datasets

library(dplyr)
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(student_math, student_por, by = join_by, suffix = c(".math", ".por") )

str(math_por)
dim(math_por)

colnames(math_por)

alc <- select(math_por, one_of(join_by))

notjoined_columns <- colnames(student_math)[!colnames(student_math) %in% join_by]
notjoined_columns


for(column_name in notjoined_columns) {
  
  two_columns <- select(math_por, starts_with(column_name))
  
  first_column <- select(two_columns, 1)[[1]]
  
if(is.numeric(first_column)) {
    
    alc[column_name] <- round(rowMeans(two_columns))
  } else { 

    alc[column_name] <- first_column
  }
}

library(dplyr); library(ggplot2)
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = (alc_use) > 2)

glimpse(alc)

write.csv(alc, "create_alc.csv")
read.csv("create_alc.csv", TRUE, ",")




















