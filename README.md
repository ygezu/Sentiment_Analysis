# Sentiment_Analysis

# Introduction 
In this project, I'm analyzing customer complaints to understand how people feel about different companies. By analyzing what the customers say, I aim to discern the levels of satisfaction or dissatisfaction with their experiences. This helps us see which companies are doing well and in what areas they could improve. Ultimately, the goal is to leverage this insight to enhance companies' customer satisfaction strategies, fostering better relationships and ensuring a positive customer experience.


# Data Cleaning 
Removing Empty Complaint Narratives: I filtered out any rows where the complaint narrative was empty to focus only on valid complaints.

df <- df %>%
  filter(Consumer.complaint.narrative != "")

Filtering Non-Provided Public Responses: Similarly, I filtered out rows where the company's public response was not provided.

df <- df %>%
  filter(Company.public.response != "")

Handling Missing Values: I addressed any missing or null values in relevant columns I utilized for this analysis, ensuring data completeness and consistency.



# Question 1- How does the sentiment score of complaints vary across the different companies?
This code performs sentiment analysis on customer complaints data. It first tokenizes the complaints text to extract individual words. Then, it retrieves a sentiment lexicon to assign sentiment scores to each word. The sentiment scores are aggregated by company, and the top 10 companies with the highest sentiment scores are identified. Finally, a bar plot is created to visualize the sentiment values for the top 10 companies.


common approaches taken by companies to resolve issues.
