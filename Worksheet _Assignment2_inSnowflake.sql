USE "PRACTICE";

SELECT * FROM "ACCIDENT";

//creating table for accident
CREATE TABLE ACCIDENT(
Accident_Index varchar(30),
Accident_Severity int);

//creating table for Vehicals
CREATE TABLE VEHICALS(
Accident_Index varchar(20),
Vehicle_Type int);

//Creting table for vehicle type
CREATE TABLE VEHICLE_TYPE(
vehicle_code INT,
vechicle_label varchar(40));

select * from accident;
select * from vehicals;
select * from vehicle_type;

//Evaluate Accident Severity and Total Accidents per vehicale type.
SELECT a.ACCIDENT_SEVERITY , COUNT(distinct(v.Accident_Index)) AS "No. Accident"
FROM vehicals AS v  
JOIN vehicle_type AS vt ON v.Vehicle_Type=vt.vehicle_code
JOIN accident AS a ON a.Accident_Index=v.Accident_Index
GROUP BY 1
ORDER BY 2 DESC;


//Calculate the avg. severity by vehicle typ
SELECT vt.VECHICLE_LABEL AS "VEHICLE", AVG(a.ACCIDENT_SEVERITY) AS "Avg. Severity"
FROM VEHICALS AS v  
JOIN VEHICLE_TYPE AS vt ON v.VEHICLE_TYPE=vt.VEHICLE_CODE
JOIN ACCIDENT AS a ON a.ACCIDENT_INDEX=v.ACCIDENT_INDEX
GROUP BY 1
ORDER BY 2;


//Calculate Avg. Severity and Total Accidents by Motorcyle.
SELECT vt.VECHICLE_LABEL AS "VEHICLE", AVG(a.ACCIDENT_SEVERITY) AS "Avg. Severity" , count(DISTINCT(v.Accident_Index)) as "No. Accident"
FROM vehicals AS v  
JOIN vehicle_type AS vt ON v.Vehicle_Type=vt.vehicle_code
JOIN accident AS a ON a.Accident_Index=v.Accident_Index
WHERE vt.VECHICLE_LABEL LIKE '%otorcycle%'
GROUP BY 1
ORDER BY 2;

--   		Task2=	"Analyzing the World Population"
CREATE OR REPLACE TABLE tbl_population(
id int,
Country_Code	Varchar(10),
Country	Varchar(100),
area	int,
area_land	 int,
area_water	int,
population	int,
population_growth	DECIMAL(5,2),
birth_rate	DECIMAL(5,2),
death_rate	DECIMAL(5,2), 
migration_rate DECIMAL(5,2));

delete  from tbl_population where id=261;
select * from tbl_population;

-- 				1. Which Country Has The Higest Population?
SELECT Country FROM tbl_population
where population=(select max(population) from tbl_population);

-- 			2.Which Country has Least no. of People? 
SELECT Country ,population FROM tbl_population
where population=(select min(population) from tbl_population)  and population is not null
order by 1;

-- 		 3. Which Country is witnessing the highest population growth?
select Country, population_growth from tbl_population
where population_growth=(select max(population_growth) from tbl_population); 

-- 		4. Which Country has an extraordinary number for the population
select Country from(
select *, dense_rank() over(order by population desc) as pk from tbl_population) as s where pk=2;

-- 	5.Which is the most densely populated country in the world
select Country from (select * ,(population/area)as population_density from tbl_POPULATION where area!=0) as t
where population_density is NOT NULL
order by population_density desc limit 1;
