# LOADING LIBS ------------------------------------------------------------

install.packages("janitor")
install.packages("pacman")
install.packages("tidyverse")
install.packages("httr") ##instalador de paquetes
library(tidyverse)
library(httr)


## httr buscar archivos de internet
## janitor formatear y limpiar los datos

# BASIC OPERATORS ---------------------------------------------------------

#inicializar
cristina <- 20
clase_lep <- c("marta", "emilia", "pablo") # la c es de combine y sirve para agrupar y convertir en array

##para coger datos de internet
#df<-httr::GET("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")
#glimpse(precios)

# GETTING DATA FROM INTERNET ----------------------------------------------

url_ <- "https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/"
df<- GET("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")

xml2::read_xml(df$content)

#que hacia esto
f_raw <- jsonlite::fromJSON(url_)

# Glimpse = genera listado en consola  de alta potencia (como view pero mejor )
df_source <- f_raw$ListaEESSPrecio %>%  glimpse()

#para limpiar los nombres de las columnas (quitar los `` de cada variable)
janitor::clean_names(df_source) %>%  glimpse()

#para saber que configuración tenemos (puntos en vez de comas...)
glimpse()
#cambiamos las "," por "." en longitud y latitud
type_convert(df_source,locale =  )
library(janitor)
df_source  %>%  clean_names()  %>% type_convert(locale= locale(decimal_mark= ",")) %>%  glimpse()
df1<-df_source  %>%  clean_names()  %>% type_convert(locale= locale(decimal_mark= ",") )



# CREATING A NEW VARIABLES ------------------------------------------------
##Clasificamos por gasolineras baratas y no caras, como lo hacemos?Que harias...
#metemos en esta variable los nombres de las gasolineras caras
df_cara<-df1%>%mutate(expensive=rotulo%in% c("CEPSA","REPSOL","BP","SHELL"))

#metemos en esta variable los nombres de las gasolineras baratas
df_low<-df1%>%mutate(expensive=!rotulo%in% c("CEPSA","REPSOL","BP","SHELL"))

#Cual es el precio medio del gasoleo en las CCAA
df_low%>%select(precio_gasoleo_a,idccaa,rotulo,expensive)%>%drop_na()%>%group_by(idccaa,expensive)%>%summarise(mean(precio_gasoleo_a))%>%view()

#cambiar idccaa por el nombre de la comunidad autonoma
df_low%>%view()

nombreccaa<-c("Andalucia","Aragón","Principado de Asturias","Islas Baleares","Canarias","Cantabria","Castilla y León","Castilla-La Mancha","Cataluña","Comunidad Valenciana","Extremadura","Galicia","Comunidad de Madrid","Región de Murcia","Comunidad Foral de Navarra","País Vasco","La Rioja","Ciudad Autónoma de Ceuta","Ciudad Autónoma de Melilla")

idccaa<-c("01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19")

ds22056779_33<-df_low
ds22056779_34<-df_low

df_ccaa<-data.frame(nombreccaa,idccaa)
ds22056779_34<-merge(ds22056779_34,df_ccaa)
ds22056779_34%>%view()

write.csv(ds22056779_33, "ds22056779_33.csv")
write.csv(ds22056779_34, "ds22056779_34.csv")










options(max.print=10000)
pacman::p_load(httr,tidyverse,leaflet,janitor,readr,sparklyr)
url_ <-("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")
httr::GET(url)
library(tidyverse)
library(janitor)
library(httr)
library(sparklyr)
library(readxl)
library(dplyr)
library(stringr)
install.packages("leaflet0")
library(leaflet)

dataset<-df_low
#Gasoleo A. Top 10 mas caras
dataset %>% select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>%
  top_n(10, precio_gasoleo_a) %>%
  leaflet() %>% addTiles() %>%
  addCircleMarkers(lng=~longitud_wgs84,lat=~latitud,popup=~rotulo,label= ~precio_gasoleo_a)
#Gasoleo A. Top 20 m?s baratas
dataset %>% select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>%
  top_n(-20, precio_gasoleo_a) %>%
  leaflet() %>% addTiles() %>%
  addCircleMarkers(lng=~longitud_wgs84, lat = ~latitud, popup = ~rotulo, label = ~precio_gasoleo_a)


#Gasoleo A. Top 10 mas caras de MURCIA
dataset %>%filter(provincia=="MURCIA")%>% select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>%
  top_n(10, precio_gasoleo_a) %>%
  leaflet() %>% addTiles() %>%
  addCircleMarkers(lng=~longitud_wgs84,lat=~latitud,popup=~rotulo,label= ~precio_gasoleo_a)
#Gasoleo A. Top 20 m?s baratas de MURCIA
dataset %>% filter(provincia=="MURCIA")%>% select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>%
  top_n(-20, precio_gasoleo_a) %>%
  leaflet() %>% addTiles() %>%
  addCircleMarkers(lng=~longitud_wgs84, lat = ~latitud, popup = ~rotulo, label = ~precio_gasoleo_a)








# READING AND WRITING (FILES) ---------------------------------------------------------

glimpse(preciosEESS_es) #invierte la tabla

