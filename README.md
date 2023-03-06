# Data332-TextAnalysis

## Introduction:
  In this project, we explore a dataset containing customer complaints for multiple companies and states, focusing on issues related to fraud alerts. Through our analysis, we answer several key questions such as the mode of complaint submission, the companies and states with the most fraud alert problems, and the sentiment of the complaints using the NRC and Bing lexicons.

Our analysis begins by examining the various modes of complaint submission, including email, fax, web, phone, referral, and post mail. Next, we identify the top three companies with the most fraud alert problems, which are Equifax, Experian, and TransUnion Intermediate Holdings, Inc. We also investigate the top three states with the most fraud alert problems, which are California, Florida, and Georgia.

Finally, we conduct a sentiment analysis using the NRC and Bing lexicons. The NRC helped us identify emotions like fear in the complaints, while the Bing lexicon gave us a score of either positive or negative for each word in the complaints. This gave us an idea of the overall sentiment expressed in the complaints. We also created a shiny app with interactive graphs for users to explore. 

## Dependencies: 
* This code is an R script.
* The libraries needed for this project are: tidytext, shiny, tidyr, dplyr, readr, ggplot2, wordcloud, sentimentr, reshape2 and stringr.
* The dataset needed is also provided in the following link: https://www.kaggle.com/datasets/ashwinik/consumer-complaints-financial-products

## Data Cleaning: 
  For the Data cleanig part I only had to select columns of interest to create sub-dataframe. Here is an example: 
  
 ![Cleaning1](https://user-images.githubusercontent.com/118494394/223169248-f323b736-b9eb-484a-aa02-983d28e1ae76.png)
  
  The result is a simplified dataframe that we were able to use to create graphs.
  
  ![Result1](https://user-images.githubusercontent.com/118494394/223169486-d2dc293f-e722-44f5-99dc-729f67fc5221.png)


  Another cleaning step that was needed was getting rid of unecessary rows to make a dataframe more tidy:
  
  ![Cleaning2](https://user-images.githubusercontent.com/118494394/223169545-6a6c7b46-5722-4567-9b3a-23395c728aa8.png)

  
  The resulted dataframe:
  
  ![Result2](https://user-images.githubusercontent.com/118494394/223169598-be22ec71-ed73-4e69-b759-192f7e6b49c0.png)


## Data Analysis:
1. What mode is most commonly used the submit complaints? 

For this question we selected the columns as shown in the first table needed and created this graph:

![SubmissionMode](https://user-images.githubusercontent.com/118494394/223169679-d46924e7-a1cd-4660-bec5-47e54ecf45f1.png)


Our graph suggests that most customers submitted their complaint via the Web.

2. Which companies face the most fraud alert probelms?

Here we choose a sub-issue from the main dataframe using the filter function and chose to focus on fraud alert problems. 
This table shows the count of the top 5 companies with most fraud alert problems.

![CompanyCount](https://user-images.githubusercontent.com/118494394/223169800-6055e544-eae8-4dea-9feb-af2778d0a850.png)

Through a simple ggplot we were able to show that the company Equifax receives most complaints in this sub-issue.

![company_count](https://user-images.githubusercontent.com/118494394/223169868-ed71a730-2f3b-4ab1-a7df-9ef5bf3252ac.png)


3. Which states face the most fraud alert probelms?

Similarly, we decided to focus on which states that have the highest rate of fraud alerts.
The following table shows that California, Florida and Georgia are the top 3 states with the highest rate. 

![StateCount](https://user-images.githubusercontent.com/118494394/223169130-c31cec2e-5365-4905-9a2f-ce195c3b7608.png)


The bar chart emphasizes our results: 

![StateFraud](https://user-images.githubusercontent.com/118494394/223169061-a71c9680-debe-475f-8059-a92d2128c2d3.png)


4. Sentiment of fear in the top 3 companies:

For this part, we focus on most common words of fear in top 3 companies with the highest rate of fraud alerts. 

![FraudComp](https://user-images.githubusercontent.com/118494394/223176162-b9a06318-efea-4903-a4a5-c3d8930f24b5.png)


As shown is the graph, for the companies Equifax, Experian and TransUnion, who face the most complains with fraud alert problems, the complaints narrative most common words of fear are: "remove", "bankruptcy", "theft" and "mortgage".


5. Sentiment of fear in the top 3 states:

Similar to part 4 but focusing on the top 3 states.

![FraudStates](https://user-images.githubusercontent.com/118494394/223174513-23142015-954f-4d90-97b0-47a1944830b8.png)

As shown is the graph, for the states California, Florida and Georgia, who face the most complains with fraud alert problems, the complaints narrative most common words of fear are: "mortgage", "case", "remove", "bankruptcy" and "attorney".


6. Contribution to sentiment:

The contribution of sentiment analysis tools, such as Bing and NRC, has shed light on the negative and positive sentiments expressed in relation to fraud alerts as shown in the graph below.

![ContributionSentiment](https://user-images.githubusercontent.com/118494394/223175025-7f14a165-3897-46e7-85e7-56fc3115de4d.png)

7. Word cloud:

Finally, the last part of our analysis is a word cloud that compares the most used words in the fraud alert complaints in the top 3 states (CA, FL, GA).

![wordcloud](https://user-images.githubusercontent.com/118494394/223175800-00f0780c-ca9d-40b7-8448-87eadc0687b9.png)

# Shiny app:
You can find specific words used in the sentiment of fear used by each companies with the highest rate of fraud alert complaints on this shiny app: [http://127.0.0.1:4267/ ](http://127.0.0.1:4267)

# Author

Lina Maatouk

# Credits
Dr. Brosius
