
# ID SCRIPT ---------------------------------------------------------------

##LENGUAJES DE PROGRAMACION ESTADISTICA
##PROFESOR:CHRISTIAN SUCUZHANAY AREVALO
##ALUMNO: IVAN BRAVO SANCHEZ, EXP: 22056779
##HANDS ON 01


# SHORCUTS ----------------------------------------------------------------

##crtl + l = clean console
##crtl + shift + r = new section


# GIT COMMANDS -----------------------------------------------------------
##git status
##git init
##git add
##git commit -m"message"
##git push -u origin main
##git branch -M
##git merge
##git remote add origin https://github.com/IvanBravoSanchez/LPE21535220
##git clone https://github.com/IvanBravoSanchez/LPE21535220.git
# TERMINAL COMMANDS -------------------------------------------------------
##ls 
##cd#cambiar directorio
##pwd#directorio
##cd ..#volver hacia atras
##mkdir
##touch#crear archivos
##nano
##less
##cat#muestra
##where#saber donde esta el archivo

# LOADING LIBS ------------------------------------------------------------

install.packages("tidyverse")
library(tidyverse)
install.packages(c("tidyverse","janitor"))




## httr coger archivos de internet
## janitor formatear y limpiar los datos
# BASIC OPERATORS ---------------------------------------------------------

alicia <-20
clase_lep<- c("marta","emilia","pablo")




##ctrl+shift+m->%>% este es el pipeline
##para coger datos de internet
df<-httr::GET("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")
glimpse(precios)

url_<-"https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/"
res_<-httr::GET("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")
xml2::read_xml(res_$content)

f_row<-jsonlite::fromJSON(url_)

df_source<-f_row$ListaEESSPrecio%>%glimpse()
library(janitor)
janitor::clean_names(df_source)%>%glimpse()

type_convert(df_source,locale=)
# READING AND WRITING(FILES) -----------------------------------------------------

