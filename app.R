library(tidytext)
library(shiny)
library(tidyr)
library(dplyr)
library(readr)
library(ggplot2)
library(gganimate)
library(wordcloud)
library(sentimentr)
library(reshape2)
library(stringr)
library(DT)

setwd("C:/Users/linamaatouk21/DATA 332-TextAnalysis")

ConsumerData <- readRDS("Consumer_Complaints.csv.rds") %>%
  dplyr::select(Company, Consumer.complaint.narrative) %>%
  ungroup() %>%
  unnest_tokens(word, Consumer.complaint.narrative)

nrc_fear <- get_sentiments("nrc") %>%
  filter(sentiment == "fear")

df <- ConsumerData %>%
  inner_join(nrc_fear) %>%
  count(Company, word, sort = TRUE) %>%
  filter(n >= 200)

ui <- fluidPage(
  titlePanel("Explore Sentiment of Fear in Companies"),
  h4("Sentiment of Fear Related to Fraud Alert Complaints"),
  fluidRow(
    column(
      2,
      selectInput("Company", "Choose Company", choices = unique(df$Company), multiple = TRUE),
      selectInput("Word", "Choose Word", choices = unique(df$word), multiple = TRUE)
    ),
    column(4, plotOutput("plot_01")),
    column(6, DT::dataTableOutput("table_01", width = "100%"))
  )
)

server <- function(input, output) {
  
  maindata <- reactive({
    df %>%
      filter(Company %in% input$Company) %>%
      filter(word %in% input$Word)
  })
  
  
  custom_colors <- c("#4B0082", "#00CED1", "#FF8C00", "#228B22")
  
  output$plot_01 <- renderPlot({
    maindata() %>%
      ggplot(aes(word, n, fill = Company)) +
      geom_col(show.legend = FALSE) +
      labs(x = "Word", y = "Count", title = "Sentiment of Fear in Top 3 Companies with Fraud Alerts") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      scale_fill_manual(values = custom_colors)
  })
  
  output$table_01 <- DT::renderDataTable(
    maindata(), 
    options = list(pageLength = 4)
  )
}

shinyApp(ui = ui, server = server)
