--1. How many unique user Ids are in each table?
-- Counting number of Ids in each table
SELECT COUNT (DISTINCT activity.Id) AS act_id, COUNT(DISTINCT sleep.Id) AS slp_id, COUNT(DISTINCT weight.Id) AS wght_id, COUNT(DISTINCT steps.Id) AS step_id
FROM my-project-408701.BellaBeat.Activity
-- Full join gives results from all tables listed independent of other table's content
FULL JOIN my-project-408701.BellaBeat.Sleep ON activity.Id = sleep.Id
FULL JOIN my-project-408701.BellaBeat.Weight ON activity.Id = weight.Id
FULL JOIN my-project-408701.BellaBeat.Steps ON activity.Id = steps.Id


-- 2. How many of users overlap in each table?
-- Counting number of distinct IDs shared by all tables
SELECT COUNT (DISTINCT activity.Id) AS act_id, COUNT(DISTINCT sleep.Id) AS slp_id, COUNT(DISTINCT weight.Id) AS wght_id, COUNT(DISTINCT steps.Id) AS step_id
FROM my-project-408701.BellaBeat.Activity
-- Inner Join results in only matching Ids found in all tables listed
JOIN my-project-408701.BellaBeat.Sleep ON activity.Id = sleep.Id
JOIN my-project-408701.BellaBeat.Weight ON activity.Id = weight.Id
JOIN my-project-408701.BellaBeat.Steps ON activity.Id = steps.Id


-- 3. What specific user Ids are in or lacking from each table?
-- Verifying IDs are consistent across tables and shows which Ids are shared or absent from tables
SELECT DISTINCT activity.Id AS act_id, sleep.Id AS slp_id, weight.Id AS wght_id, steps.Id AS step_id
FROM my-project-408701.BellaBeat.Activity
-- Full Join allows results including null values from all tables joined
FULL JOIN my-project-408701.BellaBeat.Sleep ON activity.Id = sleep.Id
FULL JOIN my-project-408701.BellaBeat.Weight ON activity.Id = weight.Id
FULL JOIN my-project-408701.BellaBeat.Steps ON activity.Id = steps.Id 


-- 4. What user ids overlap sets?
-- Change Join method to Inner Join which results in only user Ids that are found in all listed tables, exclude null values. Results in user Ids that overlap all tables
SELECT DISTINCT activity.Id AS act_id, sleep.Id AS slp_id, weight.Id AS wght_id, steps.Id AS step_id
FROM my-project-408701.BellaBeat.Activity
JOIN my-project-408701.BellaBeat.Sleep ON activity.Id = sleep.Id
JOIN my-project-408701.BellaBeat.Weight ON activity.Id = weight.Id
JOIN my-project-408701.BellaBeat.Steps ON activity.Id = steps.Id
-- These users will be used later as the "overlap" group to see if any trends are present for users that use all sets vs those that do not.
-- Analysis: Only 6 users overlap in all of the datasets used


-- 5. How much activity are users performing on average? 
-- Average Activity data and grouping by User Id. 
SELECT DISTINCT Id,
 COUNT(Id) AS logs,
 AVG(Steps) AS avg_steps,
 AVG(Total_Distance) AS avg_total_distance, 
 AVG(Very_Active_Minutes) AS avg_very_min,
 AVG(Fairly_Active_Minutes) AS avg_fair_min,
 AVG(Lightly_Active_Minutes) AS avg_light_min,
 AVG(Sedentary_Minutes) AS avg_sedentary_min,
 AVG(Calories) AS avg_calories_burned
FROM my-project-408701.BellaBeat.Activity
GROUP BY Id
ORDER BY Id
-- Saved table as dataset: “activity_avgs_by_id”
/* Analysis: 
-21 of the 33 users tracked data for the full month.
-20 got at least 7,000 steps, 7 over 10,000 steps, and 14 had below 7,000 steps. 
-20 users are getting at least 20 min of a combination of vigorous(very) and moderate(fairly) level of activity. Many exceed 20 minutes with 6 users getting over an hour of this level of activity on average.
*/ 


-- 6. How much sleep do users get on average?
-- Compile sleep data into averages by user Id
SELECT *,
(avg_min_asleep/60) AS avg_hour_asleep     
FROM (      
   SELECT DISTINCT Id,      
    COUNT(Id) AS total_logs,      
    SUM(Time_Awake) AS total_min_awake_in_bed,     
    AVG(Time_Awake) AS avg_min_awake_in_bed,     
    SUM(Total_Minutes_Asleep) AS total_min_asleep,      
    AVG(Total_Minutes_Asleep) AS avg_min_asleep     
 FROM my-project-408701.BellaBeat.Sleep    
 GROUP BY Id      
 ORDER BY Id )
-- Saved table as dataset: "sleep_totals_by_id"
/* Analysis:
-Only 3 users tracked their sleep for the full month. 
-15 of the 24 did complete at least half of the month at 15 daily logs or more 
-12 got at least 7 hours of sleep. the other 12 got less than 7 hours. 
-Most users have time disrupted from sleep, 19 of the 24 had more than 15 minutes of being awake during their sleep cycle.
*/


-- 7. Combine activity and sleep averages
-- Combine the sleep and activity data grouped by Id into one table
SELECT *
FROM my-project-408701.BellaBeat.Activity_Averages_by_ID
JOIN my-project-408701.BellaBeat.Sleep_Totals_ID ON Activity_Averages_by_ID.id = sleep_totals_id.Id
ORDER BY sleep_totalS_id.Id
-- Saved table as avg_act_sleep_by_id



-- 8. What days do the most and least activity take place on?
-- Average user activity and sleep data. Group by day to see day to day and weekly trends.
SELECT day, COUNT(Day) AS logs,
 AVG(Steps) AS avg_steps,
 AVG(Very_Active_Minutes) AS avg_very_act_min,
 AVG(Fairly_Active_Minutes) AS avg_fairly_act_min,
 AVG(Lightly_Active_Minutes) AS avg_lightly_act_min,
 AVG(Sedentary_Minutes) AS avg_sedentary_min,
 AVG(Total_Distance) AS avg_total_dist,
 AVG(Calories) AS avg_calories_burned
FROM my-project-408701.BellaBeat.Activity
GROUP BY day
ORDER BY
-- Assign a numerical value to the days so they can be ordered correctly (Otherwise SQL orders alphabetically)                  
     CASE
WHEN Day = 'Sunday' THEN 1
WHEN Day = 'Monday' THEN 2  
WHEN Day = 'Tuesday' THEN 3  
WHEN Day = 'Wednesday' THEN 4
WHEN Day = 'Thursday' THEN 5
WHEN Day = 'Friday' THEN 6
WHEN Day = 'Saturday' THEN 7
     END ASC
-- Saved this table as dataset: “avg_activity_day”
/* Analysis:
-On average users are getting over 7,000 steps except on Sundays. Users are getting over 8,000 on Tuesdays and Saturdays 
-Users are meeting the weekly recommended 150-300 minutes of activity (combination of  vigorous and moderate) at 243.44 minutes on average. 
-Users are traveling over 5 Km on average each day 
-The amount of calories burned is consistently around 2300 kcal a day with the exception of Sundays and Thursdays
-The most active day is Saturday with  244 minutes of combined activity (very, fairly, and light active levels), and the least is Sunday with 208 minutes 
-The most sedentary day is Monday with 1027.9 min and the least is Thursday with 961.9 min 
*/



-- 9. What days do users have the most and least sleep?
SELECT *,
-- Add column for minutes asleep converted to hours
(avg_min_asleep/60) AS avg_hour_asleep 
FROM (
SELECT Day, COUNT(Day) AS number_of_days,
-- Counting how many of each day is included in its grouped row.
AVG(Time_Awake) AS avg_min_awake_in_bed,   
AVG(Total_Minutes_Asleep) AS avg_min_asleep     
FROM my-project-408701.BellaBeat.Sleep   
GROUP BY Day
ORDER BY
CASE      
WHEN Day = 'Sunday' THEN 1      
WHEN Day = 'Monday' THEN 2      
WHEN Day = 'Tuesday' THEN 3     
WHEN Day = 'Wednesday' THEN 4     
WHEN Day = 'Thursday' THEN 5      
WHEN Day = 'Friday' THEN 6      
WHEN Day = 'Saturday' THEN 7      
 END ASC )
-- Saved this table as dataset: “avg_sleep_by_day”
/* Analysis: 
-Users get the most sleep and the recommended at least 7 hours on Sundays, Wednesdays, and Saturdays. The rest of the week users get 6.7-6.9 hours of sleep.  
-The more sleep users get the greater amount of time they spend in bed awake throughout the week with Sundays having an average 50 minutes of restless sleep. 
*/


-- 10. Combine activity and sleep data
-- Selecting sleep and activity level columns from activity and sleep datasets
SELECT 
 average_sleep_per_day.day,
 average_sleep_per_day.number_of_days AS sleep_logs,
 average_activity_per_day.logs AS activity_logs,
 avg_min_awake_in_bed, avg_min_asleep,
 avg_hour_asleep, avg_very_act_min,
 avg_fairly_act_min, avg_lightly_act_min, avg_sedentary_min
FROM my-project-408701.BellaBeat.Average_Sleep_per_day
-- Joining datasets to have both activity and sleep data in one set
JOIN my-project-408701.BellaBeat.Average_Activity_per_day ON average_activity_per_day.Day = average_sleep_per_day.Day
 ORDER BY   
      CASE              
          WHEN Day = 'Sunday' THEN 1
          WHEN Day = 'Monday' THEN 2
          WHEN Day = 'Tuesday' THEN 3
          WHEN Day = 'Wednesday' THEN 4
          WHEN Day = 'Thursday' THEN 5
          WHEN Day = 'Friday' THEN 6
          WHEN Day = 'Saturday' THEN 7
        END ASC;


-- 11. Are there any activity trends over time?
-- Average all results by date and sort into one row for each specific date
SELECT DISTINCT Date,
 COUNT(Id) AS logs,
 AVG(Steps) AS avg_steps,
 AVG(Total_Distance) AS avg_total_distance, 
 AVG(Very_Active_Minutes) AS avg_very_act_min,
 AVG(Fairly_Active_minutes) AS avg_fairly_act_min,
 AVG(Lightly_Active_Minutes) AS avg_light_min,
 AVG(Sedentary_Minutes) AS avg_sedentary_min,
 AVG(Calories) AS avg_calories_burned
FROM my-project-408701.BellaBeat.Activity
GROUP BY Date 
ORDER BY Date
-- Saved table as "avg_act_dates"
/* Analysis:
-Users gradually stopped logging activity data over the month with the largest decline occurring from may 8 - 12th 27 users to 21 users. 
-Users had at least 7,000 steps on 27 of the 31 days and less than 7,000 on only 4 days.
*/


-- 12. Are there any sleep trends over time?
SELECT *,
(avg_min_asleep/60) AS avg_hour_asleep ## Add column with minutes asleep converted to hours
FROM (
 SELECT DISTINCT Date,      
 COUNT(date) AS logs,      
 SUM(Time_Awake) AS total_min_awake_in_bed,     
 AVG(Time_Awake) AS avg_min_awake_in_bed,     
 SUM(Total_Minutes_Asleep) AS total_min_asleep,      
 AVG(Total_Minutes_Asleep) AS avg_min_asleep     
 FROM my-project-408701.BellaBeat.Sleep   
 GROUP BY Date  ## Results in user ids being grouped into single average entry for each date
 ORDER BY Date ) 
/* Analysis:
-Users did not use the sleep tracker consistently as seen by the variance in logs from day to day.
-16 of the 31 days users met the recommended 7 hours of sleep 
-When averaged users do get 7 hours of sleep over the month long timeline 
*/


-- 13. Combine activity and sleep data
-- Combine average activity and sleep data into one table organized by date
SELECT average_sleep_per_dates.Date, avg_steps, avg_total_distance, avg_very_act_min, avg_fairly_act_min, avg_light_min, avg_sedentary_min, avg_calories_burned, avg_min_awake_in_bed, avg_min_asleep, avg_hour_asleep,
FROM my-project-408701.BellaBeat.Average_Activity_per_Dates
JOIN my-project-408701.BellaBeat.Average_Sleep_per_dates ON Average_Activity_per_dates.Date = average_sleep_per_dates.Date
ORDER BY Date



-- 14. What are the average weights and how often are they logged?
-- Find number of times users logged weight data and average weight data entered
SELECT 
 DISTINCT Id,
 COUNT(Id) AS total_logs,
 AVG(Weight_Pounds) AS avg_weight_lbs,
 AVG(BMI) AS avg_BMI
FROM my-project-408701.BellaBeat.Weight
GROUP BY Id
ORDER BY Id
-- Saved table as dataset: "weight_avgs"
/* Analysis:
-The average weight is 171.54 pounds 
-Average BMI is 27.98
-Only 8 users tracked weight and of those only 2 checked weight a significant amount of time (24 and 30 logs)
*/


-- 15. How do number of steps vary by day?
-- Find average steps by day                        
SELECT Day, AVG(Steps) AS avg_steps                     
FROM my-project-408701.BellaBeat.Activity
GROUP BY Day                        
-- Order results by day of week. Case assigns numeric value to Days so that the order is based on value not alphabetical.                        
ORDER BY                        
     CASE                       
          WHEN Day = 'Sunday' THEN 1   
          WHEN Day = 'Monday' THEN 2
          WHEN Day = 'Tuesday' THEN 3
          WHEN Day = 'Wednesday' THEN 4
          WHEN Day = 'Thursday' THEN 5
          WHEN Day = 'Friday' THEN 6
          WHEN Day = 'Saturday' THEN 7
     END ASC 

/* Analysis: 
-Saturday has the highest step count and the least is Sunday
*/

