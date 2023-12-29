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
     
### 4. Analyze (Trends Summarized)

 I then uploaded my 4 tables into BigQuery SQL Console to begin my data analyses.
 Key findings about user trends:

 #### 1. Activity
 ![image](https://github.com/skhan060/Google-BellaBeat-CaseStudy/assets/153567661/6615b38c-3a84-4866-9ecd-272f03b3673d)

  * More time is spent performing a light level of activity than moderate or very active levels.
    
 
 ![image](https://github.com/skhan060/Google-BellaBeat-CaseStudy/assets/153567661/4c6bdfcb-5944-452c-9700-bfa42c284ec0)

  * All of the 33 users in the data sets tracked activity with 21 of them finishing the month with a daily log.
    

 ![image](https://github.com/skhan060/Google-BellaBeat-CaseStudy/assets/153567661/cd59f41a-acb9-4664-b51b-96a577485ccc)

  * There is a direct correlation between the more vigorous the activity level the more calories burned.

 #### 2. Steps

 ![image](https://github.com/skhan060/Google-BellaBeat-CaseStudy/assets/153567661/4d01ddfb-4b56-44af-a924-8591d3adb437)

  * Users are typically taking more steps on Tuesdays and Saturdays with a plateau mid week.
    

![image](https://github.com/skhan060/Google-BellaBeat-CaseStudy/assets/153567661/8d978d87-9c13-4e9e-835b-0c8b19b827b6)

  * Users gradually increase their step count throughout the day. There is a rapid rise and fall between 10am and 4pm with a peak around 6pm and then a rapid decline. 


 ![image](https://github.com/skhan060/Google-BellaBeat-CaseStudy/assets/153567661/513777e1-8232-479c-a3d5-bcd474b61120)

 * There is a direct correlation between the number of steps taken in a day and the respective calories burned. 


#### 3. Sleep


![image](https://github.com/skhan060/Google-BellaBeat-CaseStudy/assets/153567661/c27771b0-927a-4956-8dea-a7acada568ca)

  * Average sleep Varies over time for users but averages just around 7 hours a night.


![image](https://github.com/skhan060/Google-BellaBeat-CaseStudy/assets/153567661/24bf32d6-9c16-47e4-917f-c66babb08ce0)

  * Not all users tracked sleep data each night. Users are tracking their sleep inconsistently.

 #### 4. Weight

  * Only 8 of the 33 users tracked weight data and of them only 2 did so more than 5 times.
 ![image](https://github.com/skhan060/Google-BellaBeat-CaseStudy/assets/153567661/5e8a2332-49a0-46d9-835d-35ee26b71173)


  * Average pounds - 171.5

  * Average BMI 27.98 (25.0 to 29.9 falls within the overweight range according to the CDC)

### 5. Share

![image](https://github.com/skhan060/Google-BellaBeat-CaseStudy/assets/153567661/edab57e4-58f1-4bf5-9ce2-0cdbe481237b)
View  [Tableau](https://public.tableau.com/app/profile/saad.khan6444/viz/BellaBeatGoogleCaseStudy/Dashboard1#2)

### 6. Act
#### <ins>Recommendations</ins>


## 1. Target areas of health tracking that the Fitbit data suggests users could use improvement in

 * Meet the recommended 7 hours of sleep with the sleep tracker and if adequate sleep is not achieved generate a reminder. 

 * Encourage getting more than 7000 steps as a baseline goal for all users and issue activity reminders upon extendended sedentary periods.

 * Encourge weekly weight logs by settingup reminder for a particular day of the week.

## 2. Promote the positive and well rounded health feature. 

 * The data suggests users do not have an interest in weight tracking and neglect tracking sleep as well.

 * Focus should taken away form daily weight logs and more emphasis should be placed on daily sleeps logs.

 * If a poor sleep schedule is detected consistently an alarm should be issued regardng the negative effects of lack of sleep on mental and physical health.

 * An option to track intake of water shoudld also be integrated.

# In summary
 Bellabeat should continue to market their positive and well-rounded health monitoring services. Emphasize how their products, the Ivy and Leaf, can do all of the physical fitness tracking that Fitbit does that consumers like, but with the addition of the wellness score tool that can help them monitor other key aspects (hydration, stress, menstrual cycle) that make up a healthy life in an upbeat and stylish way!


## Data Manipulation and Analysis 

I then uploaded my 4 tables into BigQuery SQL Console to begin my data manipulation. Each phase of manipulation was guided by a question in search of a trend.

# Continue to:
 1. *SQL_Queries* for all queries
 2. *Data Table Link* for access to view all tables resulting for queries
 3. *Analysis* for analysis of data
 4. *Visualizations* for data graphs
 5. *Recommendations* for my answer to the business task
 6. *Sources Cited* for resource credits
