library(tidyverse)
library(sf)
library(mapview)
library(tod)



# Réseau hydrographique
# donnée chargée depuis
# https://services.sandre.eaufrance.fr/telechargement/geo/ETH/BDCarthage/FXX/2017/France_metropole_entiere/SHP/

reseau_hydro_carthage <- st_read("raw_data/TronconHydrograElt_FXX.shp")
names(reseau_hydro_carthage)
head(reseau_hydro_carthage)

reseau_hydro_carthage <- reseau_hydro_carthage %>% 
  st_transform(crs = 4326) # passage en WGS84

# visualisation 29 Nord
box = c(xmin = -50, ymin = 48.3, xmax = -4.3, ymax = 49)
reseau_29 <- reseau_hydro_carthage %>% 
  st_crop(y = box)

mapview::mapview(reseau_29)

# secteurs hydro

secteurs_hydro <-
  tod::wfs_sandre(url_wfs = "https://services.sandre.eaufrance.fr/geo/sandre",
                  couche = "SecteurHydro_FXX")

st_crs(secteurs_hydro)
st_crs(reseau_hydro_carthage)


save(reseau_hydro_carthage,
     secteurs_hydro,
     file = "processed_data/rivers.rda")
