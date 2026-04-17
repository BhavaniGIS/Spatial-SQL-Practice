-- Day 2: PostgreSQL Basic & Intermediate
-- Purpose: Handling real-world data inconsistencies and missing values.

-- 1. Finding Unique Categories (DISTINCT)
-- Use: To see a clean list of all business types without duplicates.
SELECT DISTINCT shop FROM hyd_shops;

-- 2. Case-Sensitive Filtering (LIKE)
-- Use: Finding exact matches. 'furniture' (small letters) is different from 'Furniture'.
SELECT name, shop 
FROM hyd_shops 
WHERE shop LIKE 'furniture';

-- 3. Flexible Keyword Search (ILIKE & Wildcards)
-- Use: Searching for 'MALL' anywhere in the name, ignoring capital/small letter differences.
-- The % symbol allows for any text before or after the keyword.
SELECT name FROM hyd_shops 
WHERE name ILIKE '%MALL%';

-- 4. Filtering Grouped Data (HAVING)
-- Use: Finding categories that have high density (more than 2 shops).
-- Note: WHERE filters rows; HAVING filters groups.
SELECT shop, COUNT(*)
FROM hyd_shops
GROUP BY shop
HAVING COUNT(*) > 2;

-- 5. Handling Missing Data (COALESCE)
-- Use: Replacing NULL values with a professional label for map display.
-- If 'name' is empty, it will show 'Unnamed Facility' instead of NULL.
SELECT COALESCE(name, 'Unnamed Facility') AS clean_name, shop 
FROM hyd_shops;
