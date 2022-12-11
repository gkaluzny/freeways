text <- c("Houston was originally made up of six wards. Black residents
were mainly redlined into Wards 3, 4 and 5.",
          "In the 1950s, freeways were built directly through these three neighborhoods
          with almost surgical precision.",
          "By 1970, the east half of Ward 4 that had been separated by I-45 was 
          completely gone. I-69 was completed and destroyed even more of Ward 3.",
          "In 1980, the edges of Wards 3 and 5 that were cut off by the freeways
          had experienced large declines in population, creating an even greater
          spatial barrier between these neighborhoods and the white affluent neighborhoods
          in West Houston.",
          "In 1990, the effect of Black flight on these historic Black neighborhoods
          is evident. Over the previous decades, middle class Black families left the
          city for integrated suburbs, leaving less dense, lower income Black neighborhoods
          in the city.",
          "Fifty years after the first freeways were built, Ward 4 has essentially
          ceased to exist. The parts of Wards 3 and 5 that were originally cut off
          by the freeways have also disappeared, and much of the Black population
          of Houston is stuck behind the freeways.",
          "Fifty years after the first freeways were built, Ward 4 has essentially
          ceased to exist. The parts of Wards 3 and 5 that were originally cut off
          by the freeways have also disappeared, and much of the Black population
          of Houston is stuck behind the freeways.")

year <- seq(1950, 2010, 10)

harris_text <- tibble(year, text)
