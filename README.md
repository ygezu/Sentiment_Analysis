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

Finally, I shortened the complaint statements to make the visuals appear tidier 
   
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



# Comparing the Top 10 sentiment scores calculated across the different companies 

![top_10](https://github.com/ygezu/Sentiment_Analysis/assets/159511253/7ed61b8c-99bc-4ff1-b8ae-2d4015c285de)









This code performs sentiment analysis on customer complaints data. It first tokenizes the complaints text to extract individual words. Then, it retrieves a sentiment lexicon to assign sentiment scores to each word. The sentiment scores are aggregated by company, and the top 10 companies with the highest sentiment scores are identified. Finally, a bar plot is created to visualize the sentiment values for the top 10 companies.


common approaches taken by companies to resolve issues.
