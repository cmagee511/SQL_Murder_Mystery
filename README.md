# SQL Murder Mystery
Answers to the SQL Murder Mystery challenge by Knight Lab https://mystery.knightlab.com/

## SQL Murder Mystery Schema
<img src='https://mystery.knightlab.com/schema.png'>

A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. Start by retrieving the corresponding crime scene report from the police department’s database.


## SQL Answers Script

### 1. Find Information about Witnesses
```sql

--Murder occurred sometime on Jan.15, 2018
--This happened in SQL City

SELECT *
FROM crime_scene_report
WHERE type = 'murder'
AND   date =  20180115
AND   city = 'SQL City';
```

### 2. Find information on the 2 Witnesses
```sql
-- First Witness live at the last house on "Northwestern Dr"
-- Second Witness name is 'Annabel' and lives somewhere on "Franklin Ave"

-- First Witness
SELECT *
FROM Person
Where address_street_name = "Northwestern Dr"
ORDER BY address_number DESC
Limit 1;

-- Morty Schapiro, ID 14887

-- Second Witness
SELECT *
FROM Person
Where address_street_name = "Franklin Ave"
AND   name LIKE 'Annabel%';

-- Annabel Miller, ID 16371
```

### 3. Look up Morty Schapiro & Annabel Miller in the Interview Table
```sql
-- Annabel Miller, ID 16371
-- Morty Schapiro, ID 14887

SELECT *
FROM interview 
WHERE person_id IN (16371,14887);
```

### 4. Using transcript from interview table to find the murderer
```sql
-- Last seen in gym on January 9th
-- Had Get fit now gym bag, Membership number starting with '48Z'
-- Got into a car with plate number including 'H42W'

SELECT p.*, i.*
FROM drivers_license as d
INNER JOIN person as p on d.id = p.license_id
INNER JOIN get_fit_now_member as m on p.id = m.person_id
INNER JOIN get_fit_now_check_in as i on m.id = i.membership_id
WHERE plate_number LIKE '%H42W%'
AND membership_id LIKE '48Z%'
AND membership_status = 'gold'
AND check_in_date = 20180109;

-- Murderer is Jeremy Bowers
```

### 5. Finding out who hired the murderer
```sql
-- Checking Jeremy Bowers interview
SELECT *
FROM interview
WHERE person_id = 67318;
```
```sql
-- hired by woman 
-- Height around 65" 67", Red hair, Drivers Tesla Model S
-- attended the SQL Symphony Concert 3 times in December 2017

WITH checkin AS(
SELECT person_id,
	   COUNT(*) as visits
FROM facebook_event_checkin
Where event_name = 'SQL Symphony Concert'
AND   date BETWEEN '20171201' AND '20171231'
GROUP BY person_id
HAVING visits >= 3)


SELECT p.*,i.annual_income
FROM drivers_license as d
INNER JOIN person as p ON d.id = p.license_id
INNER JOIN income as i ON p.ssn = i.ssn
INNER JOIN checkin as c ON c.person_id = p.id 
WHERE height BETWEEN '65' AND '67'
AND   hair_color = 'red'
AND   car_make = 'Tesla'
AND   car_model = 'Model S'
AND   gender = 'female';

-- Query one was to find out which ID's attended SQL Symphony Concert more than 3 times in December
-- Query two was to find out the people with height, hair color, gender & car from Jeremy Bowers interview transcript
-- Using a CTE I joined my two queries to provide one results to find who hired Jeremy Bowers
-- The person who hired Jeremy Bowers was Miranda Priestly
 ```






              
              



              







              
              



              
