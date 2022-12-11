library(tidyverse)
library(ipumsr)
library(sf)
library(tidycensus)


make_data <- function(state, county) {
  ## 1940
  data <- "Downloads/nhgis0018_csv/nhgis0018_ds76_1940_tract.csv"
  
  shape <- "Downloads/nhgis0018_shape/nhgis0018_shapefile_tl2008_us_tract_1940/US_tract_1940_conflated.shp"
  
  nhgis <- read_nhgis_sf(data_file = data, shape_file = shape)
  data_1940 <- nhgis %>%
    filter(STATEA == state, COUNTYA %in% county) %>%
    mutate(white = BUQ001,
           black = BVG001,
           other = BUQ002 - BVG001) %>%
    select(geometry, white:other) %>%
    pivot_longer(cols = -geometry, names_to = "race", values_to = "value") %>%
    mutate(race = fct_relevel(race, "white", "black", "other"))
  
  ## 1950
  data <- "Downloads/nhgis0012_csv/nhgis0012_ds82_1950_tract.csv"
  
  shape <- "Downloads/nhgis0003_shape/nhgis0003_shapefile_tl2008_us_tract_1950/US_tract_1950_conflated.shp"
  
  nhgis <- read_nhgis_sf(data_file = data, shape_file = shape)
  data_1950 <- nhgis %>%
    filter(STATEA == state, COUNTYA %in% county) %>%
    mutate(white = B0J001,
           black = B0J002,
           other = B0J003) %>%
    select(geometry, white:other) %>%
    pivot_longer(cols = -geometry, names_to = "race", values_to = "value") %>%
    mutate(race = fct_relevel(race, "white", "black", "other"))
  
  ## 1960
  data <- "Downloads/nhgis0013_csv/nhgis0013_ds92_1960_tract.csv"
  
  shape <- "Downloads/nhgis0004_shape/nhgis0004_shapefile_tl2008_us_tract_1960/US_tract_1960_conflated.shp"
  
  nhgis <- read_nhgis_sf(data_file = data, shape_file = shape)
  
  data_1960 <- nhgis %>%
    filter(STATEA == state, COUNTYA %in% county) %>%
    mutate(white = B7B001,
           black = B7B002,
           other = B7B003) %>%
    select(geometry, white:other) %>%
    pivot_longer(cols = -geometry, names_to = "race", values_to = "value") %>%
    mutate(race = fct_relevel(race, "white", "black", "other"))
  
  ## 1970
  data <- "Downloads/nhgis0006_csv/nhgis0006_ds95_1970_tract.csv"
  
  shape <- "Downloads/nhgis0006_shape/nhgis0006_shapefile_tl2008_us_tract_1970/US_tract_1970_conflated.shp"
  
  nhgis <- read_nhgis_sf(data_file = data, shape_file = shape)
  
  data_1970 <- nhgis %>%
    filter(STATEA == state, COUNTYA %in% county) %>%
    rowwise %>%
    mutate(white = sum(c(CEB001, CEB010)),
           black = sum(c(CEB002, CEB011)),
           other1 = sum(c_across(CEB003:CEB009)),
           other2 = sum(c_across(CEB012:CEB018)),
           other = sum(c(other1, other2)))%>%
    ungroup %>%
    filter(!is.na(TRACT)) %>%
    select(geometry, white, black, other) %>%
    pivot_longer(cols = -geometry, names_to = "race", values_to = "value") %>%
    mutate(race = fct_relevel(race, "white", "black", "other"))
  
  ## 1980
  data <- "Downloads/nhgis0007_csv/nhgis0007_ds104_1980_tract.csv"
  
  shape <- "Downloads/nhgis0007_shape/nhgis0007_shapefile_tl2008_us_tract_1980/US_tract_1980_conflated.shp"
  
  nhgis <- read_nhgis_sf(data_file = data, shape_file = shape)
  
  data_1980 <- nhgis %>%
    filter(STATEA == state, COUNTYA %in% county) %>%
    rowwise %>%
    mutate(white = C9D001,
           black = C9D002,
           other = sum(c_across(C9D003:C9D015))) %>%
    filter(!is.na(TRACT)) %>%
    ungroup %>%
    select(geometry, white, black, other) %>%
    pivot_longer(cols = -geometry, names_to = "race", values_to = "value") %>%
    mutate(race = fct_relevel(race, "white", "black", "other"))
  
  ## 1990
  data <- "Downloads/nhgis0008_csv/nhgis0008_ds120_1990_tract.csv"
  
  shape <- "Downloads/nhgis0008_shape/nhgis0008_shapefile_tl2008_us_tract_1990/US_tract_1990_conflated.shp"
  
  nhgis <- read_nhgis_sf(data_file = data, shape_file = shape)
  
  data_1990 <- nhgis %>%
    filter(STATEA == state, COUNTYA %in% county) %>%
    rowwise %>%
    mutate(white = EUY001,
           black = EUY002,
           other = sum(c_across(EUY003:EUY005))) %>%
    filter(!is.na(TRACT)) %>%
    ungroup %>%
    select(geometry, white, black, other) %>%
    pivot_longer(cols = -geometry, names_to = "race", values_to = "value") %>%
    mutate(race = fct_relevel(race, "white", "black", "other"))
  
  ## 2000
  data <- "Downloads/nhgis0014_csv/nhgis0014_ds146_2000_tract.csv"
  
  shape <- "Downloads/nhgis0014_shape/nhgis0014_shapefile_tl2008_us_tract_2000/US_tract_2000_conflated.shp"
  
  nhgis <- read_nhgis_sf(data_file = data, shape_file = shape)
  
  data_2000 <- nhgis %>%
    filter(STATEA == state, COUNTYA %in% county) %>%
    rowwise %>%
    mutate(white = FMR001,
           black = FMR002,
           other = sum(c_across(FMR003:FMR006))) %>%
    ungroup %>%
    select(geometry, white, black, other) %>%
    pivot_longer(cols = -geometry, names_to = "race", values_to = "value") %>%
    mutate(race = fct_relevel(race, "white", "black", "other"))
  
  ## 2010
  data <- "Downloads/nhgis0015_csv/nhgis0015_ds172_2010_tract.csv"
  
  shape <- "Downloads/nhgis0015_shape/nhgis0015_shapefile_tl2010_us_tract_2010/US_tract_2010.shp"
  
  nhgis <- read_nhgis_sf(data_file = data, shape_file = shape)
  
  data_2010 <- nhgis %>%
    filter(STATEA == state, COUNTYA %in% county)  %>%
    rowwise %>%
    mutate(white = H7X002,
           black = H7X003,
           other = sum(c_across(H7X004:H7X008))) %>%
    ungroup %>%
    select(geometry, white, black, other) %>%
    pivot_longer(cols = -geometry, names_to = "race", values_to = "value") %>%
    mutate(race = fct_relevel(race, "white", "black", "other"))
  
  ## 2020
  data <- "Downloads/nhgis0016_csv/nhgis0016_ds249_20205_tract.csv"
  
  shape <- "Downloads/nhgis0016_shape/nhgis0016_shapefile_tl2020_us_tract_2020.zip"
  
  nhgis <- read_nhgis_sf(data_file = data, shape_file = shape)
  
  data_2020 <- nhgis %>%
    filter(STATEA == state, COUNTYA %in% county)  %>%
    rowwise %>%
    mutate(white = AMPWE002,
           black = AMPWE003,
           other = sum(c_across(AMPWM004:AMPWM010))) %>%
    ungroup %>%
    select(geometry, white, black, other) %>%
    pivot_longer(cols = -geometry, names_to = "race", values_to = "value") %>%
    mutate(race = fct_relevel(race, "white", "black", "other"))
  
  data_all <- list(#data_1940,
                   data_1950,
                   data_1960,
                   data_1970,
                   data_1980,
                   data_1990,
                   data_2000,
                   data_2010,
                   data_2020) %>%
    set_names(seq(1950, 2020, by = 10))
  
  return(data_all)
}

make_dots <- function() {
  dots <- data_list %>%
    map(as_dot_density, value = "value", values_per_dot = 25, group = "race") %>%
    set_names(seq(1950, 2020, by = 10))
  
  return(dots)
}

