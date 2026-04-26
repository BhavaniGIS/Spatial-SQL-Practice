-- Day 3: PostgreSQL Intermediate Practice
-- Topic: Mastering Joins and Data Retrieval

/* 1. INNER JOIN (Intermediate Level)
   Purpose: Returns records that have matching values in both tables.
   Use Case: To find only those bike stations that are successfully assigned to a city.
*/

SELECT b.id, c.city_name 
FROM bike_points05 b
INNER JOIN city_info c ON b.city_id = c.id;


/* 2. LEFT JOIN (Intermediate Level)
   Purpose: Returns all records from the left table (bike_points05), 
            and the matched records from the right table (city_info).
   Use Case: To see all bike stations, even if they do not have a city assigned (shows NULL).
*/

SELECT b.id, c.city_name
FROM bike_points05 b
LEFT JOIN city_info c ON b.city_id = c.id;


/* 3. RIGHT JOIN (Intermediate Level)
   Purpose: Returns all records from the right table (city_info), 
            and the matched records from the left table (bike_points05).
   Use Case: To see all cities in the database, including those with no bike stations.
*/

SELECT b.id, c.city_name
FROM bike_points05 b
RIGHT JOIN city_info c ON b.city_id = c.id;


/* 4. LIMIT (Basic Level)
   Purpose: Restricts the number of rows returned in the result set.
   Use Case: To quickly preview the top 5 records of the table for data validation.
*/
SELECT * FROM bike_points05 LIMIT 5;
