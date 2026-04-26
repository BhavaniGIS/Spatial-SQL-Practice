-- #############################################################
-- DATABASE MANAGEMENT - Day 11 (PostgreSQL)
-- Focus: Indexing, Table Modification, and Advanced Queries
-- #############################################################

-- 1. PERFORMANCE OPTIMIZATION - CREATE INDEX
-- Creates a roadmap to speed up data retrieval. 
-- Useful when searching for specific names in large datasets.

CREATE INDEX idx_shop_name ON "hyd_shops"(name);

----------------------------------------------------------------

-- 2. ALTER TABLE / ADD COLUMN
-- Modifies the table structure to add new fields without deleting data.
-- Adding a 'shop_rating' column to store numeric ratings.

ALTER TABLE "hyd_shops" ADD COLUMN shop_rating NUMERIC;

----------------------------------------------------------------

-- 3. AGGREGATE FUNCTIONS (COUNT, SUM, AVG, MIN, MAX)
-- Performs calculations on a set of values and returns a single result.

SELECT 
    COUNT(*) AS total_records,        -- Total number of shops
    SUM(id) AS sum_of_ids,            -- Total sum of ID values
    AVG(id) AS average_id_value,      -- Average of all ID values
    MIN(id) AS lowest_id,             -- The smallest ID
    MAX(id) AS highest_id             -- The largest ID
FROM "hyd_shops";

----------------------------------------------------------------

-- 4. CTE (Common Table Expression) - WITH Clause
-- Creates a temporary result set (shop_list) to make the query more readable.

WITH shop_list AS (
    SELECT name, shop 
    FROM "hyd_shops" 
    WHERE shop IS NOT NULL
)
SELECT * FROM shop_list 
WHERE shop = 'stationery';

----------------------------------------------------------------

-- 5. SUBQUERIES (Query inside a Query)
-- Using a nested query to filter the main table based on a specific category.

SELECT name, shop FROM "hyd_shops" 
WHERE shop = (
    SELECT shop FROM "hyd_shops" 
    WHERE shop = 'stationery' 
    LIMIT 1
);
