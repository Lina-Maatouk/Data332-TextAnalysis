# Data332-TextAnalysis

## Introduction:
  In this project, we explore a dataset containing customer complaints for multiple companies and states, focusing on issues related to fraud alerts. Through our analysis, we answer several key questions such as the mode of complaint submission, the companies and states with the most fraud alert problems, and the sentiment of the complaints using the NRC and Bing lexicons.

Our analysis begins by examining the various modes of complaint submission, including email, fax, web, phone, referral, and post mail. Next, we identify the top three companies with the most fraud alert problems, which are Equifax, Experian, and TransUnion Intermediate Holdings, Inc. We also investigate the top three states with the most fraud alert problems, which are California, Florida, and Georgia.

Finally, we conduct a sentiment analysis using the NRC and Bing lexicons to determine the overall sentiment of the customer complaints. We use the NRC lexicon to identify the sentiment of the complaints as either fear, anger, sadness, joy, surprise, or anticipation. The Bing lexicon, on the other hand, assigns each word in the complaints a score of either positive or negative.


## Dependencies: 
* This code is an R script.
* The libraries needed for this project are: tidytext, shiny, tidyr, dplyr, readr, ggplot2, wordcloud, sentimentr, reshape2 and stringr.
* The dataset needed is also provided in the following link: https://www.kaggle.com/datasets/ashwinik/consumer-complaints-financial-products

## Data Cleaning: 
  For the Data cleanig part I only had to select columns of interest to create sub-dataframe. Here is an example: 
  ![alt text](images/Cleaning1.png)
  
  The result is a simplified dataframe that we were able to use to create graphs.
  ![alt text](images/Result1.png)

  
