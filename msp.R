library(glue)
library(tigris)

source("Documents/census/step1.R")
data_list <- make_data("27", c("053", "123"))
dots_list <- make_dots()

## Make Freeway table
road_data <- roads(state = 27, county = c(53,123))

fw <- road_data %>%
  filter(MTFCC %in% c("S1100", "S1200")) %>%
  mutate(year = case_when(FULLNAME %in% c("State Hwy 55") ~ 1960,
    FULLNAME %in% c("US Hwy 12", "I- 35 W") ~ 1970,
                          FULLNAME %in% c("I- 94", "I- 35E") ~ 1990)
  )

years <- c(seq(1950, 2020, by = 10))

make_plot <- function(y) {
  fw_year <- fw %>%
    filter(year <= y)
  data_year <- data_list %>%
    pluck(glue("{y}"))
  dots_year <- dots_list %>%
    pluck(glue("{y}"))
  
  ggplot() +
    geom_sf(data = fw_year, color = NA) +
    geom_sf(data = data_year, color = "gray") +
    geom_sf(data = dots_year, aes(color = race), size = .001) +
    geom_sf(data = fw_year) +
    scale_color_manual(labels = c("White", "Black", "Other"),
                       values = c("#377EB8", "#E41A1C", "#4DAF4A")) +
    coord_sf(xlim = c(-93.31, -93.11), ylim = c(44.92, 45.01)) +
    annotate(geom = "label", label = "Near North", x = -93.3, y = 45, size = 2) +
    annotate(geom = "label", label = "Southside", x = -93.27, y = 44.92, size = 2) +
    annotate(geom = "label", label = "Rondo", x = -93.13, y = 44.96, size = 2) +
    theme_void() +
    theme(legend.title = element_blank(),
          legend.position = "bottom")
  
  ggsave(glue("Documents/census/msp_{y}.png"), width = 6, height = 4)
}

map(years, make_plot)
