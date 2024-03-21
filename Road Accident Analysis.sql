SELECT *
FROM Road_Accident_Data

--PROBLEM STATEMENTS

--A.KPI's
--1.PRIMARY KPI'S
--Total Casualties

SELECT 
     SUM(Number_of_Casualties) as Number_of_Casualties
FROM Road_Accident_Data

 --CY Casualties
 ---Add A column for Accident Year.

SELECT 
     YEAR(Accident_Date) 
FROM Road_Accident_Data

ALTER TABLE Road_Accident_Data
ADD Accident_Yr DATE 


ALTER TABLE Road_Accident_Data
ALTER COLUMN Accident_Yr INT


UPDATE Road_Accident_Data
SET Accident_Yr = YEAR(Accident_Date) 

--..NOW CY Casualties

SELECT 
     SUM(Number_of_Casualties) as CY_Number_of_Casualties
FROM Road_Accident_Data
WHERE Accident_Yr = 2022

--PY Casualties

SELECT 
     SUM(Number_of_Casualties) as PY_Number_of_Casualties
FROM Road_Accident_Data
WHERE Accident_Yr = 2021


--YoY Change

SELECT
ROUND(
  100 *(
      CAST((SELECT SUM(Number_of_Casualties) FROM Road_Accident_Data WHERE Accident_Yr = 2022) AS FLOAT)-
	   CAST((SELECT SUM(Number_of_Casualties) FROM Road_Accident_Data WHERE Accident_Yr = 2021)AS FLOAT))/
	  CAST((SELECT SUM(Number_of_Casualties) FROM Road_Accident_Data WHERE Accident_Yr = 2021) AS FLOAT), 1) AS YoY_pct_change

--Accident Severity
--CY Fatal Casualties

SELECT 
	SUM(Number_of_Casualties) as Fatal_Casualties
FROM Road_Accident_Data
WHERE Accident_Yr = 2022 and Accident_Severity = 'Fatal'

--PY Fatal Casualties

SELECT 
	SUM(Number_of_Casualties) as Fatal_Casualties
FROM Road_Accident_Data
WHERE Accident_Yr = 2021 and Accident_Severity = 'Fatal'

--YoY pct change in Fatal Casualties.

SELECT
ROUND(
  100 *(
    CAST((SELECT SUM(Number_of_Casualties) FROM Road_Accident_Data WHERE Accident_Yr = 2022 and Accident_Severity = 'Fatal') AS FLOAT)-
	CAST((SELECT SUM(Number_of_Casualties) FROM Road_Accident_Data WHERE Accident_Yr = 2021 and Accident_Severity = 'Fatal') AS FLOAT))/
	CAST((SELECT SUM(Number_of_Casualties) FROM Road_Accident_Data WHERE Accident_Yr = 2021 and Accident_Severity = 'Fatal') AS FLOAT), 1) YoY_pct_change

--CY Slight Casualties

SELECT 
	SUM(Number_of_Casualties) as CY_Slight_Casualties
FROM Road_Accident_Data
WHERE Accident_Yr = 2022 and Accident_Severity = 'Slight'

--PY Slight Casualties

SELECT 
	SUM(Number_of_Casualties) as PY_Slight_Casualties
FROM Road_Accident_Data
WHERE Accident_Yr = 2021 and Accident_Severity = 'Slight'

--YoY pct change in Slight Casualties.

SELECT
ROUND(
  100 *(
    CAST((SELECT SUM(Number_of_Casualties) FROM Road_Accident_Data WHERE Accident_Yr = 2022 and Accident_Severity = 'Slight') AS FLOAT)-
	CAST((SELECT SUM(Number_of_Casualties) FROM Road_Accident_Data WHERE Accident_Yr = 2021 and Accident_Severity = 'Slight') AS FLOAT))/
	CAST((SELECT SUM(Number_of_Casualties) FROM Road_Accident_Data WHERE Accident_Yr = 2021 and Accident_Severity = 'Slight') AS FLOAT), 1) YoY_pct_change

--CY Serious Casualties

SELECT 
	SUM(Number_of_Casualties) as CY_Serious_Casualties
FROM Road_Accident_Data
WHERE Accident_Yr = 2022 and Accident_Severity = 'Serious'

--PY Serious Casualties

SELECT 
	SUM(Number_of_Casualties) as PY_Serious_Casualties
FROM Road_Accident_Data
WHERE Accident_Yr = 2021 and Accident_Severity = 'Serious'

--YoY pct change in Serious Casualties.

SELECT
ROUND(
  100 *(
    CAST((SELECT SUM(Number_of_Casualties) FROM Road_Accident_Data WHERE Accident_Yr = 2022 and Accident_Severity = 'Serious') AS FLOAT)-
	CAST((SELECT SUM(Number_of_Casualties) FROM Road_Accident_Data WHERE Accident_Yr = 2021 and Accident_Severity = 'Serious') AS FLOAT))/
	CAST((SELECT SUM(Number_of_Casualties) FROM Road_Accident_Data WHERE Accident_Yr = 2021 and Accident_Severity = 'Serious') AS FLOAT), 1) YoY_pct_change

--CY Total Accidents

SELECT 
     COUNT(Accident_Index) as CY_Total_Accidents
FROM Road_Accident_Data
WHERE Accident_Yr = 2022

--PY Total Accidents

SELECT 
     COUNT(Accident_Index) as PY_Total_Accidents
FROM Road_Accident_Data
WHERE Accident_Yr = 2021

--YoY_pct_Change

SELECT
ROUND(
  100 *(
    CAST((SELECT COUNT(Accident_Index) FROM Road_Accident_Data WHERE Accident_Yr = 2022) AS FLOAT)-
	CAST((SELECT COUNT(Accident_Index) FROM Road_Accident_Data WHERE Accident_Yr = 2021)  AS FLOAT))/
	CAST((SELECT COUNT(Accident_Index) FROM Road_Accident_Data WHERE Accident_Yr = 2021)  AS FLOAT), 1) YoY_pct_change

--CY Casualties by Vehicle type

SELECT
     Vehicle_Type,
	 SUM(Number_of_Casualties)
FROM Road_Accident_Data
GROUP BY Vehicle_type

ALTER TABLE Road_Accident_Data
ADD Vehicle_type_group VARCHAR(20)


SELECT
  Vehicle_Type,
  (CASE
    WHEN Vehicle_Type = 'Agricultural Vehicle' THEN 'Agriculture'
    WHEN Vehicle_Type IN ('Car', 'Taxi/Private hire car') THEN 'Car'
    WHEN Vehicle_Type IN ('Bus or coach (17 or more pass seats)', 'Minibus (8 - 16 passenger seats)') THEN 'Bus'
    WHEN Vehicle_Type IN ('Goods over 3.5t. and under 7.5t', 'Goods 7.5 tonnes mgw and over', 'Van / Goods 3.5 tonnes mgw or under') THEN 'Van'
    WHEN Vehicle_Type IN ('Motorcycle 50cc and under', 'Motorcycle over 500cc', 'Pedal cycle', 'Motorcycle over 125cc and up to 500cc', 'Motorcycle 125cc and under') THEN 'Bike'
    ELSE 'Others'
  END) AS Vehicle_type_grouping
FROM Road_Accident_Data

UPDATE Road_Accident_Data
SET Vehicle_type_group = (
  (CASE
    WHEN Vehicle_Type = 'Agricultural Vehicle' THEN 'Agriculture'
    WHEN Vehicle_Type IN ('Car', 'Taxi/Private hire car') THEN 'Car'
    WHEN Vehicle_Type IN ('Bus or coach (17 or more pass seats)', 'Minibus (8 - 16 passenger seats)') THEN 'Bus'
    WHEN Vehicle_Type IN ('Goods over 3.5t. and under 7.5t', 'Goods 7.5 tonnes mgw and over', 'Van / Goods 3.5 tonnes mgw or under') THEN 'Van'
    WHEN Vehicle_Type IN ('Motorcycle 50cc and under', 'Motorcycle over 500cc', 'Pedal cycle', 'Motorcycle over 125cc and up to 500cc', 'Motorcycle 125cc and under') THEN 'Bike'
    ELSE 'Others'
  END) 
)

SELECT
     Vehicle_type_group,
	 SUM(Number_of_Casualties) AS No_of_Casualties_by_vehicle_type
FROM Road_Accident_Data
WHERE Accident_Yr = 2022
GROUP BY Vehicle_type_group
ORDER BY 2 DESC


--Monthly trend showing comparison of Casualties of CY and PY

SELECT 
     Accident_Date,
	 DATENAME(MONTH, Accident_Date)
FROM Road_Accident_Data

ALTER TABLE Road_Accident_Data
ADD Month_Name VARCHAR(20)

UPDATE Road_Accident_Data
SET Month_Name = DATENAME(MONTH, Accident_Date)

SELECT 
    MONTH(Accident_Date) Month_Number,
	Month_Name,
	Accident_Yr,
	SUM(Number_of_Casualties) AS Caualties_by_Month
FROM Road_Accident_Data
GROUP BY MONTH(Accident_Date),Accident_Yr,Month_Name
ORDER BY 3,1

--Casualties by Road_type CY

SELECT 
     Road_Type,
     SUM(Number_of_Casualties) as Casualties_by_Roadtype
FROM Road_Accident_Data
WHERE Accident_Yr = 2022
GROUP BY Road_Type

--Casualties by Area CY

SELECT 
     Urban_or_Rural_Area,
     SUM(Number_of_Casualties) as Casualties_by_area
FROM Road_Accident_Data
WHERE Accident_Yr = 2022
GROUP BY Urban_or_Rural_Area

--Casualties by Day/Night

SELECT 
     Light_Conditions,
     SUM(Number_of_Casualties) as Casualties_by_LightConditions
FROM Road_Accident_Data
WHERE Accident_Yr = 2022
GROUP BY  Light_Conditions


