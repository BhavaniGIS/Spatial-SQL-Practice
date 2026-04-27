-- #############################################################
-- DATABASE MANAGEMENT - Day 12 (PostgreSQL)
-- Focus: Pagination, Views, Materialized Views, Data Deletion, and Performance Analysis
-- #############################################################

-- 1. OFFSET (Pagination)
-- Skips a specific number of rows. Useful for fetching data in pages.
-- Example: Skips first 5 records and shows the next 10.

SELECT * FROM "hyd_shops" 
ORDER BY id 
LIMIT 10 OFFSET 5;

----------------------------------------------------------------

-- 2. CREATE VIEW (Virtual Table)
-- Creates a shortcut for a complex query. It does not store data physically.
-- It always reflects the real-time data from the main table.

CREATE VIEW stationery_shops AS 
SELECT name, shop 
FROM "hyd_shops" 
WHERE shop = 'stationery';

-- To view the output of the View:
SELECT * FROM stationery_shops;

----------------------------------------------------------------

-- 3. MATERIALIZED VIEW (Physical Snapshot)
-- Saves the query result as a physical table to increase performance.
-- Highly useful for large GIS datasets.

CREATE MATERIALIZED VIEW stationery_shops_mview AS 
SELECT name, shop 
FROM "hyd_shops" 
WHERE shop = 'stationery';

-- To view the output of the Materialized View:
SELECT * FROM stationery_shops_mview;

-- REFRESH MATERIALIZED VIEW:
-- Since Materialized Views store data physically, use this to get latest updates.
REFRESH MATERIALIZED VIEW stationery_shops_mview;

----------------------------------------------------------------

-- 4. TRUNCATE / DROP (Data Management)
-- Best practice: Always test deletion on a dummy table first.

-- Step 4.1: Creating a dummy table for testing
CREATE TABLE test_shops AS SELECT * FROM "hyd_shops";

-- Step 4.2: TRUNCATE TABLE
-- Deletes all records inside the table but keeps the columns/structure.
TRUNCATE TABLE test_shops;

-- Step 4.3: DROP TABLE
-- Completely removes the table and its definition from the database.
DROP TABLE test_shops;

----------------------------------------------------------------

-- 5. QUERY PERFORMANCE ANALYSIS (EXPLAIN ANALYZE)
-- This command is used to understand how the database executes a query.
-- It shows the execution time and whether it is using an INDEX or performing a full table scan.

EXPLAIN ANALYZE SELECT * FROM "hyd_shops" WHERE name = 'Ratnadeep';
