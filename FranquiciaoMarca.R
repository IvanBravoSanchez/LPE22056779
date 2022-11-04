# LOADING LIBS --------------------------------------------------
## Instalamos las librerías necesarias
if(!require("pacman")) install.packages("pacman")
p_load(tidyverse, httr, janitor, magrittr)

# READING AND WRITING (FILES) ----------------------------------
## Obtenemos los datos con la URL de la API
url_ <- "https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/"
f_raw <- jsonlite::fromJSON(url_)

df_source <- f_raw$ListaEESSPrecio %>% as_tibble() %>% glimpse()

## Limpieza
data <- df_source %>% clean_names() %>% type_convert(locale = locale(decimal_mark = ",")) %>% glimpse()


#para saber si estas gasolineras son marcas o franquicias yo creo que no es posible con este dataset. Falta algun dato que te lo indique.
#De todas formas, voy a cosiderar que las gasolineras con S.L. y S.A. son franquicias y las que no son marcas.
data %<>% tidyr::extract(rotulo, c("extension"), "(S\\.L|S\\.A|\\bSL\\b|\\bSA\\b)", remove = F) %>% mutate(Franquicia = extension %in% c("SL", "SA", "S.A", "S.L"))

data$Franquicia <- plyr::mapvalues(data$Franquicia, from = c("TRUE", "FALSE"), to = c("Si", "No"), warn_missing = F)
data %>% view()



