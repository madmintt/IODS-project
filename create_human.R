#Data wrangling
#25.11.2019

#Reading the data 

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#exploring the data

dim(hd)
dim(gii)
str(hd)
str(gii)
summary(hd)  
summary(gii)
colnames(hd)
colnames(gii)
#The human development data has 195 observations and 8 variables. The gii data has also 195 observations ans 10 variables.

#Giving new names to the variables in the both datasets
#Gii (GII Rank and country I didnt change)

head(gii)
colnames(gii)<- c("GII.Rank", "Country", "GenIneq","Matmort", "AdolBR", "ParlPres", "SecEduFem", "SecEduMal", "LabFFem", "LabFMal")

#HD (The names of "HDI.Rank" and "country" I didnt change)

colnames(hd)<- c("HDI.Rank", "Country", "HumDevIn", "LifeExp", "ExpEdu","MeanEdu", "GNI", "GNIRank")

# Adding new variables in the gii data (The between gender ratios in secondary education and labour force participation) 

gii <- mutate(gii, edu2Ratio =SecEduMal / SecEduFem)
gii <- mutate(gii, labRatio = LabForcFem / LabForcMal)

# Joining the two datasets

join_by <-c("Country")
human <- inner_join(gii, hd, by = join_by, suffix = c(".gii", ".hd"))
dim(human)
glimpse(human)
colnames(human)

write.csv(human, "create_human.csv")
read.csv("create_human.csv", TRUE, ",")