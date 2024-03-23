library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(stringr)
library(tidytext)
library(textdata)
library(janeaustenr)
library(wordcloud)
rm(list=ls())

df <-  read.csv('Consumer_Complaints.csv')

get_sentiments("afinn")
get_sentiments("bing")
get_sentiments("nrc")

column_names <- colnames(df)
print(column_names)


#Cleaning up the data
df <- df %>%
  filter(Consumer.complaint.narrative != "")

df <- df %>%
  filter(Company.public.response != "")



#How does the sentiment score of complaints vary across different companies?
df_tidy <- df %>%
  unnest_tokens(word, Consumer.complaint.narrative)

sentiments_lexicon <- get_sentiments("bing")

#Joining the complaints data with the sentiment lexicon
df_sentiment <- df_tidy %>%
  inner_join(sentiments_lexicon, by = "word", relationship = "many-to-many") %>%
  count(Company, sentiment) %>%
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) %>%
  mutate(sentiment_value = positive - negative)

df_sentiment_score <- df_sentiment %>% group_by(Company) %>% 
  summarise(sum_sentiment=sum(sentiment_value),
            .groups = 'drop') %>%
  as.data.frame()
#put the data above in descending order
df2<-df_sentiment_score[order(df_sentiment_score$sum_sentiment, decreasing = TRUE),]

top_10<-df2[1:10,]

#top 5 companies plot
ggplot(data = top_10, aes(x = Company, y = sum_sentiment)) +
  geom_bar(stat = "identity", fill = "orange") +
  labs(title = "Top 10 Companies with Good Sentiments",
       x = "Company", y = "Sentiment Value") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


#What are the most common responses to complaints from the top 10 companies?
top_10_companies <- df[df$Company %in% top_10$Company, ]

# Count the occurrences of each type of response for the top 10 companies
response_counts <- table(top_10_companies$Company.public.response)

# Convert the table to a data frame
response_df <- data.frame(Response = names(response_counts),
                          Count = as.numeric(response_counts))

# Define the mapping from original response values to shorter descriptions
response_mapping <- c("Company chooses not to provide a public response" = "No Public Response",
                      "Company believes it acted appropriately as authorized by contract or law" = "Acted Appropriately by Law",
                      "Company believes the complaint is the result of a misunderstanding" = "Misunderstanding",
                      "Company believes complaint caused principally by actions of third party outside the control or direction of the company" = "Third-party Issue",
                      "Company disputes the facts presented in the complaint" = "Disputed Presented Facts",
                      "Company can't verify or dispute the facts in the complaint" = "Unverifiable Facts",
                      "Company believes complaint is the result of an isolated error" = "Isolated Error",
                      "Company believes complaint represents an opportunity for improvement to better serve consumers" = "Improvement Opportunity",
                      "Company believes complaint relates to a discontinued policy or procedure" = "Discontinued Policy",
                      "Company has responded to the consumer and the CFPB and chooses not to provide a public response" = "Response to only consumer and CFPB")

# Replace the response values with the shorter descriptions
response_df$Response <- response_mapping[response_df$Response]

# Create a bar plot
ggplot(response_df, aes(x = Response, y = Count)) +
  geom_bar(stat = "identity", fill = "darkblue") +  
  labs(title = "Most Common Company Public Responses for Top 10 Companies",
       x = "Company Public Response", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))



#WordCloud of 100 words
get_sentiments("nrc") %>% 
  filter(sentiment %in% c("positive", "negative")) %>% 
  count(sentiment)

get_sentiments("bing") %>% 
  count(sentiment)


bing_word_counts <- df_tidy %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()
bing_word_counts %>%
  group_by(sentiment) %>%
  slice_max(n, n = 10) %>% 
  ungroup() %>%
  mutate(word = reorder(word, n))
  
bing_word_counts %>%
  anti_join(stop_words) %>%
  count(word) %>%
  with(wordcloud(word, n, max.words = 80))

#Visual for Data Summary 
df_sentiment_score_2 <- df_sentiment %>%
  group_by(Company) %>%
  summarise(sum_sentiment = sum(sentiment_value), .groups = 'drop') %>%
  filter(Company %in% top_10$Company)

