text <- c("Researchers at the University of Minnesota have found over 30,000 racial
          covenants made by white communities between 1910 and 1950 that legally prevented people who
          were not white from buying property in their communities. These racial
          covenants made it so almost the entire Black population were only allowed
          to live in three neighborhoods: Near North and Southside in Minneapolis,
          and Rondo in St. Paul.",
          "In the 1950s, State Highway 55 was built through Near North, destroying
          homes and essentially erasing the south half of the neighborhood.",
          "In the 1960s, I-94 was built directly through Rondo,
          displacing thousands of homes and people and causing an estimated one in
          eight Black St. Paul residents to lose their homes. Similarly, I-35W was built
          directly through Southside, destroying fifty square blocks and tearing apart
          the neighborhood.",
          "By 1980, Rondo and Southside were no longer considered to be neighborhoods. Many of the Black residents had moved
          to different parts of the cities or suburbs. I-35W continued to serve as
          a dividing line between Black and White neighborhoods.",
          "In the 1980s, the remainder of I-94 was finished, further cutting off
          Near North from the rest of Minneapolis.",
          "By 2000, much of the non-white population of Minneapolis outside of Near
          North is wedged between I-35W and Highway 55, and south of I-94.",
          "In the 2000s and 2010s, Downtown Minneapolis saw a resurgence and an increase in
          population. The low-income Near North did not see a similar resurgence, 
          and I-94 became one of the clearest spatial barriers of segregation in
          the Twin Cities.",
          "In the 2000s and 2010s, Downtown Minneapolis saw a resurgence and an increase in
          population. The low-income Near North did not see a similar resurgence, 
          and I-94 became one of the clearest spatial barriers of segregation in
          the Twin Cities."
          )

year <- seq(1950, 2020, 10)

msp_text <- tibble(year, text)