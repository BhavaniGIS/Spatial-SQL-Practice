-- ==========================================
-- DAY 5: Data Manipulation Language (DML)
-- ==========================================

-- 1. INSERT COMMAND (Concept)
-- Standard way to add a new record.
INSERT INTO bike_points05 (id, city_id) 
VALUES (1010, 5);


-- 2. UPDATE & VERIFICATION (Action)
-- Modifying existing data and verifying the change.
UPDATE bike_points05 
SET city_id = 500 
WHERE id = 2;

-- Check if city_id changed to 500
SELECT * FROM bike_points05 WHERE id = 2;


-- 3. DELETE & VERIFICATION (Cleanup)
-- Removing a record and confirming its absence.
DELETE FROM bike_points05 
WHERE id = 2;

-- Should return no results (Verification Success)
SELECT * FROM bike_points05 WHERE id = 2;
