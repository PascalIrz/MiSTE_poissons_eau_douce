library(tidyverse)
library(sf)
library(mapview)
library(tod)
library(riverdist)

load(flie = "processed_data/rivers.rda")




MyRivernetwork <- line2network(path="raw_data", layer="TronconHydrograElt_FXX")