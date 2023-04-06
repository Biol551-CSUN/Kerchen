#### Shiny App Lecture ####
### Created by: Mikayla Kerchen
### Updated on: 2023-04-06
##################################

#### Load Libraries ####

library(shiny)
library(tidyverse)

#### Making a Shiny App ####

ui <- fluidPage(
      sliderInput(inputId = "num", #ID name for input
                  label = "Choose a number", # Label above the slider
                  value = 25, min = 1, max = 100 # Values for the slider
  ),
      textInput(inputId = "title", # New ID is title
                label = "Write a title",# Makes a test box above the plot
                value = "Histogram of Random Normal Values"), # What shows in the text box before re-typing 
  
      plotOutput("hist"),  # Creates space for a plot called hist
      verbatimTextOutput("stats") # Create space for stats
)

server <- function(input, output) {
  data <- reactive({
    tibble(x = rnorm(input$num))
  })
  output$hist <- renderPlot({
    # R code to make histogram goes here
    data <- tibble(x = rnorm(input$num)) # The number of random data points can be adjusted by the slider
    ggplot(data(), aes(x=x))+ 
    geom_histogram()+
    labs(title = input$title) # Add a new title
  })
  output$stats <- renderPrint({
    # R code goes here
    summary(data()) # Calculate summary stats for normal distribution 
  })
}

shinyApp(ui = ui, server = server)

