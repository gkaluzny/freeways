library(shiny)

ui <- navbarPage("Visualizing Freeways and Race",
                 tabPanel("About",
                          p("Transportation Secretary Pete Buttigieg made news when he said that the
        Department of Transportation would use $1 billion from the 2021 infrastructure
        bill to remedy racial inequities in freeway design. This policy is the culmination
        of years of focus on the racist intent of freeway placement during the 1950s 
        and 1960s."),
                          p("City planners used the Interstate Highway Act to enact racist policies
        in two main ways. The first was to use freeways to destroy Black communities.
        Almost every major American city has an example of a freeway that was built
        directly through a Black neighborhood that displaced many Black residents."),
                          p("Sometimes, policymakers were explicit in their desire to destroy Black neighborhoods.
        In Miami, leaders had publicly been searching for a way to remove the Black
        residents from Overtown. The Interstate Highway Act gave them this opportunity,
        and they changed the original freeway plans that bipassed Overtown to route
        the freeway right through it. They would describe these neighborhoods as 
          \"blight\" and defend the destroying of them as \"slum clearance\""),
                          p("Other cities chose to route freeways through Black neighborhoods simply
          because it was easier. Black communities had little to no representation
          in city governments, and did not have the political power that whites did.
          There are many examples of successful movements of white communities to 
          prevent freeways through their neighborhoods, but very few examples of Black
          communities achieving the same success."),
                          p("The second racist application of the act, and the one more relevant today, 
        is the use of freeways to maintain segregation. In the early 20th century,
        redlining and racial covenants made it so Black people could only live in certain
        neighborhoods. In the 1950s, Courts were starting to rule that this segregation 
        was illegal, and cities wanted a new way to keep Blacks and Whites separate.
        Cities often built freeways on or close to the racial zoning borders in attempts
        to keep white neighborhoods white.
        "),
                          p("The impacts of this plan to use freeways to maintain
          segregation are still felt today. There are still many cities where freeways
          serve as physical boundaries that isolate Black neighborhoods. Though 
          segregation has been illegal for decades, many of these freeways are still
          standing and still segregating."),
                          p("This project looks at racial dot maps in cities over
          time and the impact of the building of freeways on the racial makeup of
          the city. Use the interactive slider to examine how freeways were built
          directly through Black neighborhoods and how they have maintained segregation
          over the last 70 years.")
                 ),
                 tabPanel("Houston",
                          sidebarLayout(
                            sidebarPanel(shinyWidgets::sliderTextInput(inputId = "year1",
                                                                       label = "Year",
                                                                       choices = c(1950, 1960, 1970, 1980, 1990, 2000, 2010),
                                                                       grid = TRUE)
                                         
                            ),
                            
                            # Main panel for displaying outputs ----
                            mainPanel(
                              
                              # Output: Histogram ----
                              imageOutput(outputId = "image1"),
                              textOutput(outputId = "text1")
                              
                            ))
                          ),
                 tabPanel("Minneapolis-St. Paul",
                          sidebarLayout(
                            sidebarPanel(shinyWidgets::sliderTextInput(inputId = "year2",
                                                                       label = "Year",
                                                                       choices = c(1950, 1960, 1970, 1980, 1990, 2000, 2010),
                                                                       grid = TRUE,
                                                                       animate = animationOptions(interval = 3000,
                                                                                                  loop = FALSE))
                                         
                            ),
                            
                            # Main panel for displaying outputs ----
                            mainPanel(
                              
                              # Output: Histogram ----
                              imageOutput(outputId = "image2"),
                              textOutput(outputId = "text2")
                              
                            ))
                 ))
  

server <- function(input, output) {
  library(tidyverse)
  source("harris_text.R")
  source("msp_text.R")

  output$image1 <- renderImage({
  filename <- glue::glue("harris_{input$year1}.png")
  list(src = filename, height = "100%", deleteFile = FALSE)
  
    
  })
  
  output$text1 <- renderText({
    harris_text %>%
    filter(year == input$year1) %>%
    pull(text)
  })


output$image2 <- renderImage({
  filename <- glue::glue("msp_{input$year2}.png")
  list(src = filename, height = "100%", deleteFile = FALSE)
  
  
})

output$text2 <- renderText({
  msp_text %>%
    filter(year == input$year2) %>%
    pull(text)
})
}

shinyApp(ui = ui, server = server)