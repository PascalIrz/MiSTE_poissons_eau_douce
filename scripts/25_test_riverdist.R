library(tidyverse)
library(sf)
library(mapview)
library(tod)
library(riverdist)

load(file = "processed_data/rivers.rda")
load(file = "processed_data/20_selected_data.RData")

test <- points_geo %>% 
  st_join(secteurs_hydro)

# qq points hors secteurs hydro. A gérer plus tard
test %>% 
  filter(is.na(gid)) %>% 
  mapview()

mapview(secteurs_hydro)

# test sur gid 63
bv63 <- secteurs_hydro %>% filter(gid == 63)

reseau63 <- reseau_hydro_carthage %>%
  st_join(bv63) %>% 
  filter(!is.na(CdSecteurHydro)) %>% 
  st_make_valid()

stations63 <- points_geo %>% 
  st_join(bv63) %>% 
  filter(!is.na(CdSecteurHydro)) %>% 
  st_make_valid()

mapview(reseau63) +
  mapview(stations63)


st_crs(bv63)
st_crs(secteurs_hydro)
MyRivernetwork <- line2network(sf = reseau63, reproject = st_crs(4326)$proj4string)
