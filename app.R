library(tidytext)
library(shiny)
library(tidyr)
library(dplyr)
library(readr)
library(ggplot2)
library(wordcloud)
library(sentimentr)
library(reshape2)
library(stringr)
library(DT)

cleandata <- read_rds("cleandata.rds")

ui <- fluidPage(
  titlePanel("Explore Sentiment of Fear in Companies"),
  h4("Sentiment of Fear Related to Fraud Alert Complaints"),
  fluidRow(
    column(
      2,
      selectInput("Company", "Choose Company", choices = unique(cleandata$Company), multiple = TRUE),
      selectInput("Word", "Choose Word", choices = unique(cleandata$word), multiple = TRUE)
    ),
    column(4, plotOutput("plot_01")),
    column(6, DT::dataTableOutput("table_01", width = "100%"))
  )
)

server <- function(input, output) {
  
  maindata <- reactive({
    cleandata %>%
      filter(Company %in% input$Company) %>%
      filter(word %in% input$Word)
  })
  
  
  output$plot_01 <- renderPlot({
    maindata() %>%
      ggplot(aes(word, n, fill = Company)) +
      geom_col(show.legend = TRUE) +
      labs(x = "Word", y = "Count", title = "Sentiment of Fear in Top 3 Companies with Fraud Alerts") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) 
  })
  
  output$table_01 <- DT::renderDataTable(
    maindata(), 
    options = list(pageLength = 4)
  )
}

shinyApp(ui = ui, server = server)