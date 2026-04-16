-- Day 1: PostgreSQL Basic & Intermediate Practice
-- Purpose: Practicing Selection, Filtering, Grouping, and Sorting.

-- 1. Simple Selection
SELECT name, shop FROM hyd_shops;

-- 2. Filtering (Finding only Supermarkets)
SELECT * FROM hyd_shops WHERE shop = 'supermarket';

-- 3. Grouping & Counting (Business distribution)
-- This is an Intermediate level query
SELECT shop, COUNT(*) 
FROM hyd_shops 
GROUP BY shop;

-- 4. Sorting (Alphabetical order)
SELECT name FROM hyd_shops ORDER BY name ASC;
