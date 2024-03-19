# Accident_Analytics
![accident-driving](https://github.com/Olayinkacovenant/Accident_Analytics/assets/37605719/1fb41331-20ce-4551-8ca8-6b7c32c66c89)

## Table of Content
- [Project Overview](#project-overview)
- [Data Sources](#data-sources)
- [Tools](#tools)
- [Data Preparation](#data-preparation)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Data Analysis](#data-analysis)
- [Results](#results)
- [Recommendations](#recommendations)

### Project Overview
---
Accident Analytics is a data analysis project aimed at extracting meaningful insights from road accident data. The project utilizes a dataset containing information about road accidents, including factors such as accident severity, number of vehicles involved, light conditions, junction details, day of the week, weather conditions, road surface conditions, vehicle types, speed limits, and time of day.

### Data Sources
Road Accident Data: The primary dataset used for this analysis is the “Road accident data.csv” file, which contains detailed information about road accidents in a particular region.

### Tools
MySQL – For Data Cleaning and Analysis

### Data Preparation
The following tasks were performed:
- Data Loading and Inspection
- Data Cleaning and Formatting

### Exploratory Data Analysis
The following were investigated:
1.	Count of Accident Severity: Provides a breakdown of accidents by severity.
2.	Number of Vehicles Involved in Accidents: Shows the frequency of accidents based on the number of vehicles involved.
3.	Light Conditions: Displays the distribution of accidents based on light conditions.
4.	Accident Severity and Light Conditions: Analyzes the relationship between accident severity and light conditions.
5.	Junction Detail and Accident Severity: Examines how junction detail correlates with accident severity.
6.	Day of Week: Shows the distribution of accidents by day of the week.
7.	Road Surface Conditions: Presents the frequency of accidents according to road surface conditions.
8.	Vehicle Type: Provides insights into the involvement of different vehicle types in accidents.
9.	Weather Conditions: Displays the distribution of accidents based on weather conditions.
10.	Area (Urban/Rural): Contrasts the frequency of accidents in urban and rural areas.
11.	Speed Limit: Analyzes accidents by speed limit.
12.	Accident Severity and Speed Limit: Examines the relationship between accident severity and speed limit.
13.	Time of Day: Shows the distribution of accidents by time of day.

### Data Analysis
```sql
-- Count of Accident Severity
SELECT Accident_severity, COUNT(accident_severity) AS Accident_count
FROM road_accident
GROUP BY Accident_severity;

-- Number of Vehicles
SELECT number_of_vehicles, COUNT(*) AS accident_count
FROM road_accident
GROUP BY number_of_vehicles
ORDER BY accident_count DESC;

-- Light Conditions
SELECT light_conditions, COUNT(*)  
FROM road_accident
GROUP BY light_conditions;

-- Accident severity and light conditions
SELECT
    Light_conditions,
    SUM(CASE WHEN Accident_severity = 'Fatal' THEN Accident_count ELSE 0 END) AS Fatal,
    SUM(CASE WHEN Accident_severity = 'Serious' THEN Accident_count ELSE 0 END) AS Serious,
    SUM(CASE WHEN Accident_severity = 'Slight' THEN Accident_count ELSE 0 END) AS Slight
FROM (
    SELECT Accident_severity, Light_conditions, COUNT(*) AS Accident_count
    FROM road_accident
    GROUP BY Accident_severity, Light_conditions
) AS S1
GROUP BY Light_conditions;

-- Junction detail and Accident severity
SELECT junction_detail, accident_severity, COUNT(junction_detail) AS accident_count
FROM road_accident
GROUP BY 1, 2
ORDER BY 2, 3 DESC;

-- Day of week
SELECT day_of_week, COUNT(*) AS accident_count
FROM road_accident
GROUP BY day_of_week;

-- Vehicle Type
SELECT Vehicle_type, COUNT(*) 
FROM road_accident
GROUP BY Vehicle_type
ORDER BY 2 DESC;

-- Time of day
SELECT time_indicator, COUNT(time_indicator)
FROM (
    SELECT 
        accident_severity, 
        time,
        CASE 
            WHEN Time BETWEEN '12:00' AND '16:30' THEN 'afternoon'
            WHEN Time BETWEEN '6:00' AND '9:59' THEN 'morning'
            WHEN Time BETWEEN '10:00' AND '11:59' THEN 'morning'
            WHEN Time BETWEEN '16:31' AND '19:00' THEN 'evening'
            ELSE 'night'
        END AS time_indicator
    FROM road_accident
) subquery
GROUP BY time_indicator;
```
### Results
The analysis of road accident data from the 'road_accident' dataset yielded several significant findings:
1.	Accident Severity Distribution:
•	Majority of accidents are categorized as "Slight", followed by "Serious" and "Fatal".
2.	Number of Vehicles Involved:
•	Most accidents involve two vehicles simultaneously.
3.	Light Conditions:
•	Daytime records the highest occurrence of accidents compared to other light conditions.
4.	Accident Severity and Light Conditions:
•	Severity of accidents doesn't directly correlate with light conditions. Absence of light doesn't necessarily lead to more severe accidents.
5.	Junction Detail and Accident Severity:
•	Certain junction details might have higher accident counts, though not uniformly distributed across accident severities.
6.	Day of the Week:
•	Fridays witness the highest percentage of accidents, whereas Sundays record the lowest count.
7.	Vehicle Type:
•	Cars are the most frequently involved vehicles in accidents. Additionally, vans with goods under 3.5 tonnes are more involved compared to heavier vans.
8.	Time of Day:
•	Afternoon witnesses the highest occurrence of accidents, followed by evening and morning. Nighttime records the least accidents.

### Recommendations
Based on the findings from the analysis of road accident data, several recommendations can be made to improve road safety and reduce the frequency and severity of accidents:
-	Increase Awareness and Enforcement of Speed Limits:
Since many accidents happen where the speed limit is 30 mph, we should make sure people stick to these limits, especially in areas where accidents are common.
-	Improve Junction Safety:
Junctions with higher accident counts should be evaluated to identify potential safety hazards. This might involve redesigning junction layouts, adding traffic signals, or implementing traffic calming measures to reduce accident risks.
