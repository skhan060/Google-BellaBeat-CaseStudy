# Google-BellaBeat-CaseStudy

##  📝 Introduction: 
The **BellaBeat Case Study** is an end of course capstone project for the **Google Data Analytics Certificate** offered by Coursera. In this project, I will perform real world tasks as an efficient data analyst following the data analysis process of <ins>ask, prepare, process, analyze, share and act</ins> to analyze the data made available. This study showcases the skills learned during the course including SQL and Tableau. I will be analyzing Fitbit data to make a recommendation to Bellabeat by using the data analysis process.  

## 💬 Background: 

Bellabeat is a successful small company, but they have the potential to become a larger player in the global smart device market. It's mission is to empower women to reach their full fitness potential. The company offers smart devices such as: leaf, ivy, and time. These items can track health data such as activity, sleep, menstrual cycles, heart rate, and hydration. I have been asked to focus on one of Bellabeat’s products and analyze smart device data to gain insight into how consumers are using their smart devices. These insights will help guide marketing strategy for the company. Bellabeat's competitor, Fitbit, will be analyzed to reveal user trends in the wellness device market.

## Data Sources

The data source, ["Fitbit Fitness Tracker Data"](https://www.kaggle.com/arashnic/fitbit) was found on data science and coding website, Kaggle by data scientist, Möbius. The datasets were sourced from a survey performed on Amazon Mechanical Turk workers for a [study](https://www.google.com/url?q=https%3A%2F%2Fwww.researchprotocols.org%2F2017%2F4%2Fe66%2F&sa=D&sntz=1&usg=AOvVaw3Coma2iK-d62qUR9JIjAKx) which collected Fitbit tracking data.  The original study states 30 participants were surveyed, however 33 can be found in the data. No demographic information such as age, height, or sex was provided. The exact Fitbit models are not specified, but it is noted that variation across the datasets is potentially due to varying device models and user tracking preferences. The data in my analysis is focused during 4-12-2016 to 5-12-2016. The data includes a total of 33 users over 4 datasets tracking data including: physical activity, steps count, sleep time, and weight information. 

## ⚙ Approach/Steps
### 1. Ask

Three questions will guide the future marketing program:

1. What are some trends in smart device usage?
2. How could these trends apply to Bellabeat customers?
3. How could these trends help influence Bellabeat marketing strategy?

### 2. Prepare
#### 🔗 Quick Links

**Data Source:** ["Fitbit Fitness Tracker Data"](https://www.kaggle.com/arashnic/fitbit) <br>
[Note that the data has been made available by data science and coding website, Kaggle by data scientist, Möbius. The datasets were sourced from a survey performed on Amazon Mechanical Turk workers for a [study](https://www.google.com/url?q=https%3A%2F%2Fwww.researchprotocols.org%2F2017%2F4%2Fe66%2F&sa=D&sntz=1&usg=AOvVaw3Coma2iK-d62qUR9JIjAKx) 

**Tools:** <br>
- Data cleaning & processing - SQL on Google Big Query & Spreadsheets (.CSV)
- Data visualization - [Tableau](https://public.tableau.com/app/profile/saad.khan6444/viz/BellaBeatGoogleCaseStudy/Dashboard1#2)

### 3. Process
The basis for this analysis is **4-12-2016 to 5-12-2016** data and the steps for processing the data are as follow:
1) [Data Combining]
2) [Data Exploration]
3) [Data Cleaning]
4) [Data Analysis]

#### Data Selection
The 4 tables from **Fitbit Fitness Tracker Data** were selected.

 1. "Daily Activity Merged"
 2. "Hourly Steps Merged"
 3. "Sleep Day Merged"
 4. "Weight Log Info Merged"

#### Data Exploration

 1. "Daily Activity Merged" includes daily activity logs for 33 users.  This set compiles 3 activity types, their distance, minutes spent performing them. The 3 activity types are: light, fairly and very active. The distance columns are not defined but based on the step data provided resemble Kilometers. Minutes spent without activity are categorized as sedentary time. This set also includes steps taken and calories burned. 

 2. "Hourly Steps Merged" includes the same 33 user Ids, but expands the daily steps into hourly increments categorized in 24 hour format. As mentioned previously, there was a variance between the total steps calculated in this set compared to the daily logs in the "Daily Activity Merged" set above, likely due to device usage. Because of this variance I used the step information in this set only for my analysis on steps per time of day.

 3. "Sleep Day Merged", details 24 user Ids, their minutes asleep, and minutes in bed but not asleep. [Fitbit’s website](https://help.fitbit.com/articles/en_US/Help_article/2163.htm) states that the watch tracks heart rate and movement patterns to determine if the user is awake or asleep. Fitbit also states that the “Awake” category includes when users are somewhere in a sleep cycle but are restless and wake up briefly. 

 4. "Weight Log Info Merged", includes only 8 user Ids, weight (kg and lbs), BMI, and whether the data was logged manually or automatically. The set also included a “Fat” column but was only utilized in 2 cells.

#### The Cleaning Process

For this project I used Microsoft Excel and SQL for data cleaning. I started the cleaning process by checking all of my datasets for the same issues: blank spaces, duplicates, and inconsistencies. The following  is my changelog for the cleaning process in Excel:

1. Shared Changes Across All Tables 
   * Removed blank spaces using conditional formatting  
   * Verified User Id column entries were uniform (10 characters) in length using LEN function (i.e. =LEN(A2))
   * Added underscores between words in column names
   * Added column “Day” using date function ( i.e. =TEXT(B2, "dddd"))
   * Changed “DateTime” columns into two separate columns, “Date” and “Time” using INT function (i.e. =INT(A2),  =A2 - INT(A2))

2. Activity

   * Changed column name “activitydate” to “Date”

   * Changed column name “totalsteps” to “steps”

   * Removed "Tracker Distance", "Logged_Activities_Distance", "Very_Active_Distance", "Moderately_Active_Distance", "Light_Active_Distance", and "Sedentary_Active_Distance" columns. 

3. Sleep

   * Changed column name “sleepday” to “Date”

   * Subtracted "Time Asleep" from column "Total Time In Bed" and created new column "Time Awake" from results.

   * Removed column "Total Sleep Records"

4. Weight

   * Changed column name “Is Manual Report” to “Report_Type”

   * Changed column “Report_Type” Responses from True/False to Manual/Automatic respectively

   * Removed column “Fat”

   * Removed column “LogId”

## Data Manipulation and Analysis 

I then uploaded my 4 tables into BigQuery SQL Console to begin my data manipulation. Each phase of manipulation was guided by a question in search of a trend.

# Continue to:
 1. *SQL_Queries* for all queries
 2. *Data Table Link* for access to view all tables resulting for queries
 3. *Analysis* for analysis of data
 4. *Visualizations* for data graphs
 5. *Recommendations* for my answer to the business task
 6. *Sources Cited* for resource credits
