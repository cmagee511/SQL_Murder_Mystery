--Murder occurred sometime on Jan.15, 2018
--This happened in SQL City

SELECT *
FROM crime_scene_report
WHERE type = 'murder'
AND   date =  20180115
AND   city = 'SQL City';

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

-- Annabel Miller, ID 16371
-- Morty Schapiro, ID 14887

SELECT *
FROM interview 
WHERE person_id IN (16371,14887);

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

-- Checking Jeremy Bowers interview
SELECT *
FROM interview
WHERE person_id = 67318;

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

SELECT d.*, p.*,i.annual_income
FROM drivers_license as d
INNER JOIN person as p ON d.id = p.license_id
INNER JOIN income as i ON p.ssn = i.ssn
INNER JOIN checkin as c ON c.person_id = p.id 
WHERE height BETWEEN '65' AND '67'
AND   hair_color = 'red'
AND   car_make = 'Tesla'
AND   car_model = 'Model S'
AND   gender = 'female';

-- The person who hired Jeremy Bowers was Miranda Priestly
