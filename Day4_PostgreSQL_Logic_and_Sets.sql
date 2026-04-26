/* 1. Filtering with BETWEEN and IN (Basic Level)
   Purpose: Selects records within a specific ID range OR specific city IDs.
*/
SELECT id, city_id
FROM bike_points05
WHERE id BETWEEN 1 AND 500
OR city_id IN (1, 2, 3, 4, 5);


/* 2. CASE Statement (Intermediate+ Level)
   Purpose: Adds conditional logic to categorize data into labels.
   Note: Replaced 'Smart Quotes' with 'Straight Quotes' to fix the error.
*/

SELECT id, city_id,
       CASE 
            WHEN city_id IS NULL THEN 'Unknown City'
            WHEN city_id < 10 THEN 'Small City ID' 
            ELSE 'Large City ID' 
       END AS city_category
FROM bike_points05
LIMIT 10;


/* 3. UNION (Intermediate Level)
   Purpose: Combines unique results from two queries into one list.
   Use Case: Selecting the first 5 and last 5 records together.
*/

(SELECT id, 'First 5' as label FROM bike_points05 ORDER BY id LIMIT 5)
UNION 
(SELECT id, 'Last 5' as label FROM bike_points05 ORDER BY id DESC LIMIT 5);


/* 4. UNION ALL (Intermediate Level)
   Purpose: Combines all results from two queries, including duplicates if any.
*/
(SELECT id, 'First 5' as label 
 FROM bike_points05
 ORDER BY id ASC
 LIMIT 5)
UNION ALL 
(SELECT id, 'Last 5' as label 
 FROM bike_points05
 ORDER BY id DESC
 LIMIT 5);


/* 5. Fixed Casting Query (Basic Level)
   Purpose: Concatenating text with a numeric column using CAST.
*/
SELECT id, 'Bikes count is ' || CAST(id AS TEXT) AS bike_info 
FROM bike_points05 
LIMIT 5;
