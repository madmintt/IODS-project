#Prepearing the datasets

BPRS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
names(BPRS)
str(BPRS)
summary(BPRS)
dim(BPRS)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

names(RATS)
str(RATS)
summary(RATS)
dim(RATS)

#The data BPRS is about breaf psychiatric rating scale done for 40 males randomly signed to two treatment groups. Participants symptoms like hallucinations and hostility have been measured every week during eight weeks aiming to found symptoms of schitzophrenia.
#The data RATS is about three groups of rats with different nutrition for 9 weeks and measured aproximately once a week. After compairing the growth curves of the rats with different diets.

library(dplyr)
library(tidyr)

#Factoring the categorical variables
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))
RATSL <- RATS %>%
  gather(key = "WD", value = "Weight", -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4)))

# Glimpse the data
glimpse(RATSL)
glimpse(BPRSL)

str(BPRSL)
names(BPRSL)
summary(BPRSL)
str(RATSL)
names(RATSL)
summary(RATSL)
# In the wide form of the data, the 40 men and the 16 rats are the observations and the timepoins are the variables but in the long form of data each timepoint of every rat and every man are the observations. 
