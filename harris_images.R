library(glue)
library(tigris)

source("Documents/census/step1.R")
data_list <- make_data(48, 201)
dots_list <- make_dots()

## Make Freeway table
road_data <- roads(state = 48, county = 201)

fw <- road_data %>%
  filter(MTFCC == "S1100") %>%
  mutate(year = case_when(FULLNAME %in% c("Gulf Fwy") ~ 1960,
                          FULLNAME %in% c("I- 10", 
                                          "North Fwy", 
                                          "Eastex Fwy",
                                          "I- 610") ~ 1960,
                          FULLNAME %in% c("Southwest Fwy", 
                                          "State Hwy 225") ~ 1970,
                          FULLNAME %in% c("US Hwy 290",
                                          "State Hwy 288") ~ 1980,
                          FULLNAME %in% c("Beltway 8", 
                                          "Beltway 8 E N",
                                          "Hardy Toll Rd",
                                          "Tomball Pkwy",
                                          "State Hwy 249",
                                          "S Sam Houston Pkwy E",
                                          "S Sam Houston Pkwy W") ~ 1990,
                          FULLNAME %in% c("US Hwy 90", 
                                          "State Hwy 99",
                                          "State Hwy 146") ~ 2000,
                          FULLNAME %in% c("Fort Bend Pkwy", 
                                          "State Spur 330") ~ 2010
                                          ))

years <- c(seq(1950, 2010, by = 10))

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
  coord_sf(xlim = c(-95.47, -95.26), ylim = c(29.7, 29.81)) +
  annotate(geom = "label", label = "4", x = -95.39, y = 29.76) +
  annotate(geom = "label", label = "3", x = -95.35, y = 29.72) +
  annotate(geom = "label", label = "5", x = -95.32, y = 29.79) +
  theme_void() +
  theme(legend.title = element_blank(),
        legend.position = "bottom")

ggsave(glue("Documents/census/harris_{y}.png"), width = 6, height = 4)
}

map(years, make_plot)
