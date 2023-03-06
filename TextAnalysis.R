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


rm(list=ls())
setwd("C:/Users/linamaatouk21/DATA 332-TextAnalysis")

get_sentiments("afinn") 
get_sentiments("bing")
get_sentiments("nrc")

#read as an rds file
ComsumerData <- read.csv("Consumer_Complaints.csv")
saveRDS(ComsumerData, file = "Consumer_Complaints.csv.rds")
ComsumerData <- readRDS("Consumer_Complaints.csv.rds")

#simplified data frame 
df1 <- ComsumerData %>%
  dplyr::select(Product, Issue, Company, State, Submitted.via)


ggplot(df1, aes(x = Issue, fill = Product)) +
  geom_bar() +
  theme(axis.text.x = element_blank(), axis.title.x = element_blank())

#mostly submitted via web as shown in this graph
ggplot(df1, aes(x = Issue, fill = Submitted.via)) +
  geom_bar() +
  labs(fill = "Submitted via") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  theme(axis.text.x = element_blank(), axis.title.x = element_blank())

#Fraud alerts per company/state
df2 <- ComsumerData %>%
  dplyr::select(Sub.issue, Company, State)%>%
  filter(Sub.issue == "Problem with fraud alerts")


# Which companies deal with fraud alerts the most?
company_count <- df2 %>%
  count(Company, sort = TRUE) %>%
  top_n(5)

# Create a bar chart of the top 5 companies
ggplot(company_count, aes(x = n, y = Company)) +
  geom_bar(stat = "identity", fill = "deepskyblue") +
  labs(title = "Top 5 Companies with Most Problems with Fraud Alerts") +
  xlab("Count") +
  ylab("Company") +
  theme(plot.title = element_text(hjust = 1.25))

# Which states deal with fraud alerts the most?
state_count <- df2 %>%
  count(State, sort = TRUE) %>%
  top_n(5)

# Create a bar chart of the top 5 states
ggplot(state_count, aes(x = State, y = n)) +
  geom_bar(stat = "identity", fill = "orchid") +
  labs(title = "Top 5 States with Most Problems with Fraud Alerts") +
  xlab("State") +
  ylab("Count")

df3 <- ComsumerData %>%
  dplyr::select(Company, Product, Issue, State, Consumer.complaint.narrative)
sum(is.na(df3$Consumer.complaint.narrative))
df3$Consumer.complaint.narrative[df3$Consumer.complaint.narrative == ""] <- NA
df3 <- df3 %>%
  drop_na(Consumer.complaint.narrative)

#sentiment of fear found in the top 3 companies with fraud alert problems
nrc_fear <- get_sentiments("nrc") %>%
  filter(sentiment == "fear")

fearbyCompany <- df3 %>%
  unnest_tokens(word, Consumer.complaint.narrative)%>%
  filter(Company == "Equifax" | Company == "Experian" | 
  Company == "TransUnion Intermediate Holdings, Inc.") %>%
  inner_join(nrc_fear) %>%
  count(Company, word, sort = TRUE) %>%
  filter(n >= 200)

# Chart 1: Sentiment of fear found in the top 3 companies with fraud alert problems
ggplot(fearbyCompany, aes(word, n,fill = Company)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~Company, ncol = 2, scales = "free_x") +
  labs(x = "Company", y = "Count", title = "Sentiment of Fear in Top 3 Companies with Fraud Alerts") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


#sentiment of fear found in the top 3 states with fraud alert problems
fearbyState <- df3 %>%
  unnest_tokens(word, Consumer.complaint.narrative)%>%
  filter(State == "CA" | State == "FL" | State == "GA") %>%
  inner_join(nrc_fear) %>%
  count(State, word, sort = TRUE) %>%
  filter(n >= 600)

# Chart 2: Sentiment of fear found in the top 3 states with fraud alert problems
ggplot(fearbyState, aes(word, n, fill = State)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~State, ncol = 2, scales = "free_x") +
  labs(x = "State", y = "Count", title = "Sentiment of Fear in Top 3 States with Fraud Alerts") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#bing sentiment
bing_sentiments <- df3 %>%
  unnest_tokens(word, Consumer.complaint.narrative) %>%
  inner_join(get_sentiments("bing"))

get_sentiments("nrc") %>%
  filter(sentiment %in% c("positive", "negative")) %>%
  count(sentiment)
get_sentiments("bing") %>%
  count(sentiment)

#shows how much each word contributed to each sentiment using
bing_word_counts <- bing_sentiments %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()

bing_word_counts %>%
  group_by(sentiment) %>%
  slice_max(n, n = 10) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word, fill = sentiment)) + 
  geom_col(show.legend = TRUE) + 
  #facet_wrap(~sentiment, scales = "free_y") +
  labs(x = "Contribution to sentiment",
       y = NULL)

#wordcloud 
fearbyState%>%
  #dplyr:::anti_join.data.frame(., stop_words)%>%
  filter(State == "CA") %>%
  with(wordcloud(word, n, max.words = 100))

df3 %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("gray20", "gray80"),
                   max.words = 100)