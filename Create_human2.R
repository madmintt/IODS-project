# Week 5, data wrangling continues...

library("stringr")
library("dplyr")

human <- read.table("create_human.csv", sep  =",", header = T)
human <-human[ ,-1]
dim(human)
str(human)
summary(human)
colnames(human)

#This data is a joined data set, witch includes 
#variables from HDI (Human development index) and GII 
#(Gender inequality index). The HDI has measured 
#human development by three dimensions; Health, 
#learning/education and standard of living. 
#The variables of GII data measures the inequality 
#between genders giving numbers for example the 
#differences in empowerment, health and labour force.
#This combined dataset has 195 observations and 19 
#variables.For some reason there appears an extra 
#variable "x" with values 1,2,3...195 at first 
#column. I just removed it from the data.

#Changing variable GNI from factor to numeric

str(human$GNI)
human$GNI <- str_replace(human$GNI, pattern=",", replace ="")%>% as.numeric
human <- mutate(human, GNI = str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric)
str(human$GNI)

#Excludig the unneeded variables and removing rows with missing values.

keep <- c("Country","labRatio","edu2Ratio", "LifeExp","ExpEdu", "GNI", "Matmort", "AdolBR", "ParlPres")
human <- select(human, one_of(keep))
complete.cases(human)
data.frame(human[-1], comp = "complete.cases(human")
human_ <- filter(human, complete.cases(human))

dim(human_)

#Removing the last seven observations (regions in the "Country")

last <- nrow(human) - 7
human_ <- human[1:last, ]
dim(human_)


rownames(human_) <- human_$Country
rownames(human_)
dim(human_)

human_ <- select(human, -Country)
dim(human_)

