-- Day 13 : Postgis
-- Geospatial Data Analysis and Quality Control Queries

-----------------------------------------------------------
-- 1. ST_Difference (Area Subtraction)
-----------------------------------------------------------
-- General query:
SELECT ST_Area(ST_Difference(ST_Buffer(ST_MakePoint(78.4, 17.3)::geography, 100)::geometry, ST_Buffer(ST_MakePoint(78.4, 17.3)::geography, 50)::geometry));

-- Map layer query:
-- Layer Name: Ring_Area_Visualization
SELECT 1 AS id, 'Ring_Area' AS name, ST_Difference(ST_Buffer(ST_MakePoint(78.47, 17.36)::geography, 1000)::geometry, 
       ST_Buffer(ST_MakePoint(78.47, 17.36)::geography, 500)::geometry) AS geom;


-----------------------------------------------------------
-- 2. ST_Transform (System Change)
-----------------------------------------------------------
-- General query:
SELECT name, ST_AsText(ST_Transform(geom, 3857)) FROM hyd_shops LIMIT 1;

-- Map layer query:
-- Layer Name: Hyd_Shops_Projected_3857
SELECT row_number() OVER () AS id, name, ST_Transform(geom, 3857) AS geom FROM hyd_shops;


-----------------------------------------------------------
-- 3. ST_Simplify (Geometry Optimization)
-----------------------------------------------------------
-- General query:
SELECT 
    ST_NPoints(geom) AS original, 
    ST_NPoints(ST_Simplify(geom, 0.01)) AS simplified 
FROM bike_points05 
LIMIT 5;

-- Map layer query:
-- Layer Name: Bike_Routes_Simplified
SELECT row_number() OVER () AS id, ST_Simplify(geom, 0.001) AS geom FROM bike_points05;


-----------------------------------------------------------
-- 4. ST_IsValid & ST_MakeValid (Data Quality)
-----------------------------------------------------------
-- General query:
SELECT name, ST_IsValidReason(geom) FROM hyd_shops WHERE ST_IsValid(geom) = false;

SELECT name, ST_IsValidReason(geom) FROM hyd_shops WHERE ST_IsValid(geom) = true;

-- Map layer query:
-- Layer Name: Hyd_Shops_Validated
SELECT row_number() OVER () AS id, name, ST_MakeValid(geom) AS geom FROM hyd_shops;


-----------------------------------------------------------
-- 5. ST_Dump
-----------------------------------------------------------
-- General query:
SELECT (ST_Dump(geom)).geom AS single_geom FROM bike_points05 LIMIT 5;

-- Map layer Query:
-- Layer Name: Bike_Routes_Exploded
SELECT row_number() OVER () AS id, (ST_Dump(geom)).geom AS geom 
FROM bike_points05;
