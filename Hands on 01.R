# PRUEBA 1

# ID SCRIPT ---------------------------------------------------------------

## LENGUAJES DE PROGRAMACION ESTADÍSTICA
## PROFESOR: CHRISTIAN
## ALUMNO: ALE MONTES DE OCA
## HANDS ON 01

# INGEST FUNCTION ---------------------------------------------------------


# SHORTCUTS ---------------------------------------------------------------

## control + l = clean console
## control + shift + r = new section


# LOADING LIBS ------------------------------------------------------------

install.packages (c("tidyverse", "httr","janitor"))
install.packages ("tidyverse")
install.packages ("httr")
install.packages("janitor")
library(tidyverse)
library(janitor)
library(httr)
read_csv()
read.csv()
readr::
# utils se usa para diferenciar los comandos
# Usar funcion Combined (c) para que el vector de packages funcione
install.packages(c("tidyverse","httr","janitor"))

# GIT COMMANDS ------------------------------------------------------------

#git status
#git init
#git add
#git commit -m "message"
#git push
#git push -u origin main
#git branch -M
#git merge
#git remote add origin urldelproyecto
#git clone urldeloquequeremosclonarjiji
#git fetch

# TERMINAL COMANDS --------------------------------------------------------

#ls listar
#cd ir directorio?
#pwd sasber donde estamos
#cd.. volver atras
#mkdir crear directorio
#touch crear archivo
#nano invocar un notepad
#less R_Gas
#cat lo mismo que less pero no permite pmover el ratón
#clear
#were encontrar archivo
#wich lo mismo

# BASIC OPERATIONS --------------------------------------------------------

#(variable) saber atributos (enviroment)
alicia <- 20

#guardar varios elementos del mismo tipo
clase_lep <- c("marta","emilia","pablo")

# si queremos poner varios tipos de datos hay que usar las listas
lista_prueba <- list("marta", 42)

#%>% #ctrl + shift + m con tidyverse

# GETTING DATA FROM INTERNET ----------------------------------------------
url <- ("url")
df <- GET("url")

# Ejemplo gasolineras
url_ <-("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")
df <- GET("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")
View(df)
xml2::read_xml(df$content)
#janitor::clean_names(df_source) %>% glimpse() # CAMBIAR DE CHAR A FLOAT
#type_convert(df_source,locale())

# READING AND WRITTING ( FILES ) ------------------------------------------
f_raw <- jsonlite::fromJSON(url_)

## Guardamos el dataset en una variable y visualizamos.
df_source <- f_raw$ListaEESSPrecio %>% glimpse() # Glimpse = genera listado en consola
# Cambiamos las , del dataset
df_final <- df_source %>%janitor::clean_names()%>%type_convert(locale = locale(decimal_mark = ","))

preciosEESS_es <- read_excel("/Users/aleemc11/Desktop/LPE/TERMINAL CLASE 2 LPE 23:09:22.rtf")

## Como crear columnas

## Clasificamos gasolineras barartas y no baratas, como lo hacemos? Usar el view de tribble
df_final%>%view()

## Funcion mutate para crear columna con nombre, rotulo es donde están los nombres. Df es para qe sepa donde esta rotulo-
df_low <- df_final%>%mutate(expensive = !rotulo %in% c("CEPSA", "REPSOL", "BP", "SHELL")) # ! para encontrar las baratas (lo contrario a las caras)

## Cual precio medio de gasoleo en las CCAA
df_low %>% select(precio_gasoleo_a, idccaa, rotulo, expensive) %>% drop_na() %>% group_by(idccaa, expensive) %>% summarise(mean(precio_gasoleo_a)) %>% view()
df_low %>% glimpse()

## Columna que informe a que CCAA corresponde cada precio TRABAJO EN CASA ENTREGA 2

## creamos dos con 32 y 33 columnas y guardamos el df utilizado anteriormente.
ds22013334_33 <- df_low
ds22013334_34 <- df_low

comunidades <- c("Andalucía","Aragón","Principado de Asturias", "Illes Balears","Canarias", "Cantabria",
                 "Castilla y León","Castilla-La Mancha","Cataluña","Comunitat Valenciana","Extremadura",
                 "Galicia","Comunidad de Madrid","Región de Murcia","Comunidad Foral de Navarra",
                 "País Vasco","La Rioja","Ciudad Autónoma de Ceuta","Ciudad Autónoma de Melilla")

indices <- c("01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19")

# Unimos los df anteriores
df_ccaa_ind_provincias <- data.frame(comunidades, indices)

ds22013334_34 <- merge(ds22013334_34, df_ccaa_ind_provincias)

#Visualizamos el resultado
ds22013334_34%>%view()

# Extraemos los datasets

write.csv(ds22013334_33,"C:\\Users\\aleemc11\\Desktop\\LPE22013334\\ds22013334_33.csv", row.names = FALSE)
write.csv(ds22013334_34,"C:\\Users\\aleemc11\\Desktop\\LPE22013334\\ds22013334_34.csv", row.names = FALSE)




