browseURL("https://github.com/IvanBravoSanchez/LPE22056779.git")
import("pacman")
if (!require("pacman"))install.packages("pacman")
pacman::p_load(pacman, magrittr, productplots, psych, RColorBrewer, tidyverse)
#pacman=load and unload
#magrittr= bidirecctional piping
#productplots=graficos y cat var
#psych=estadisticas
#RCOlorBrewer=pintar y colorear


# LOAD AND PREPARE DATA ---------------------------------------------------

browseURL("http://j.mp/37Wxvv7")
df<-happy%>%as_tibble()
que_tipo<-happy
levels(df$happy)
#reverse levels
df%<>%mutate(happy=fct_rev(happy))
df%>%ggplot()+geom_bar(aes(happy, fill=happy))+
  theme(axis.title.x = element_blank(),legend.position = "none")
df%>% count(happy)
df%<>%select(happy:health)%>%  view()
df%<>%filter(!is.na(happy))
df%>% count(happy)


df%>% ggplot(aes(df$sex, fill=happy))+geom_bar(position="fill")


# HAPPINESS AND EDUCATION LEVEL -------------------------------------------
df %>%  ggplot(aes(degree, fill=happy))+geom_bar(position = "fill")

# HAPPINESS AND MONEY -----------------------------------------------------
df %>%  ggplot(aes(finrela, fill=happy))+geom_bar(position = "fill")

# HAPPINESS AND HEALTH ----------------------------------------------------
df %>%  ggplot(aes(health, fill=happy))+geom_bar(position = "fill")



# DICHOTOMUS MARRIED / NOT VARIABLE ---------------------------------------
df%<>%mutate(married=if_else(marital=="married","yes", "no"))%>%
  mutate(married=as.factor(married))%>%view()

