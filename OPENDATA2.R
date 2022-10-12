install.packages("httr")
install.packages("tidyverse")


library(readr)
infartos<-read_csv("C:/Users/Ivan Bravo/OneDrive/Documentos/heart_2020_cleaned.csv")
View(infartos)


library(tidyverse,httr)
dfOD2<-httr::GET("https://www.kaggle.com/datasets/kamilpytlak/personal-key-indicators-of-heart-disease?select=heart_2020_cleaned.csv")
