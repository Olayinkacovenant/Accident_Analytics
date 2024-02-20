select * from road_accident

-- Count of Accident Severity
Select Accident_severity, count(accident_severity) as Accident_count
from road_accident
group by Accident_severity

-- NUMBER OF VEHICLES
Select number_of_vehicles, count(*) as accident_count
from road_accident
group by number_of_vehicles
order by accident_count desc
-- The number of cars mostly involved in an accident at a time is 2

-- Light Conditions
select light_conditions, count(*)  from road_accident
group by light_conditions
-- The result shows that the highest number of accidents occur at daytime 

-- Accident severity and light conditions
SELECT
    Light_conditions,
    SUM(CASE WHEN Accident_severity = 'Fatal' THEN Accident_count ELSE 0 END) AS Fatal,
    SUM(CASE WHEN Accident_severity = 'Serious' THEN Accident_count ELSE 0 END) AS Serious,
    SUM(CASE WHEN Accident_severity = 'Slight' THEN Accident_count ELSE 0 END) AS Slight
FROM (
Select Accident_severity, Light_conditions, count(*) as Accident_count
from road_accident
group by Accident_severity, Light_conditions
) AS S1
GROUP BY Light_conditions;
-- There is more to the average severity than light conditions. Absence of light is not necessarily the cause
-- of how severe the accident would be.

-- Junction detail and Accident severity
Select junction_detail, accident_severity, count(junction_detail) AS accident_count
from road_accident
-- where junction_detail in ('T or staggered junction', 'crossroads')
group by 1, 2
order by 2, 3 desc

-- In %
select junction_detail, accident_count, accident_count*100 / sum(accident_count) over() as accident_count_pct
from(
select junction_detail, count(*) as accident_count
from road_accident
group by junction_detail) subquery
order by accident_count_pct desc;

--  Day of week
select day_of_week, count(*) as accident_count
from road_accident
Group by day_of_week
-- In %
select day_of_week, day_count, day_count*100 /sum(day_count)over() as percentage_day
from
(Select day_of_week, count(*) as day_count
from road_accident
group by day_of_week) subquery2
order by percentage_day desc;
-- The lowest amount of accidents occur on Sunday while the highest percentage is on Friday


-- Road surface conditions
Select road_surface_conditions, count(*) 
from road_accident
group by road_surface_conditions


-- Vehicle Type
Select Vehicle_type, count(*) from road_accident
group by 1
order by 2 desc
-- This shows that cars are more involved in accidents 
-- This also reveals that van with goods under 3.5 tonnes that are involved in accidents are more than vans
-- with goods over 7.5tonnes and vans with goods between these ranges are less involved in accidents
-- Also, motorcycle with over 500cubic capacity are more involved in accidents than ones with lesser cubic capacity
-- Big buses with 17 or more passengers seats are more involved in accidents than mini buses.


-- weather conditions
Select weather_conditions, count(*) as weather_count
from road_accident
group by weather_conditions
order by weather_count desc
-- Most accidents occured when the weather was fine and there were no high winds

-- Area
SELECT 
    (SELECT COUNT(*) FROM road_accident WHERE urban_or_rural_area = 'urban') AS URBAN,
    (SELECT COUNT(*) FROM road_accident WHERE urban_or_rural_area = 'RURAL') AS RURAL;
-- Accidents occur more in urban areas 

-- Speed limit
select speed_limit, count(*) as speed_limit_count
from road_accident
group by speed_limit
order by speed_limit_count desc
-- Accidents occur mostly when the speed limit is at 30.

select accident_severity, speed_limit, count(speed_limit)
from road_accident
group by 1,2
order by 2, 3 desc
-- Although, it is shown that most slight accidents occur at 30, fatal accidents occur at higher speed limits

-- Time of day
select time_indicator, count(time_indicator)
from (
Select accident_severity, time,
		case when Time between '12:00' and '16:30' then 'afternoon'
			 when Time between '6:00' and '9:59' then 'morning'
              when Time between '10:00' and '11:59' then 'morning'
             when Time between '16:31' and '19:00' then 'evening'
		     else 'night'
             end as time_indicator
from road_accident
) subquery
group by Time_indicator
-- Accidents occur mostly in the afternoon

