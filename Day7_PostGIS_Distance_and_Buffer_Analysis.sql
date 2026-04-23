---------------------------------------------------------
-- DAY 7: ST_DISTANCE AND ST_BUFFER ANALYSIS
---------------------------------------------------------

-- 1. ST_DISTANCE ANALYSIS
---------------------------------------------------------

-- [General Query: Attribute Data]
-- Used for reports to see the distance in meters.
SELECT name,
       ST_Distance(geom::geography, ST_MakePoint(78.4, 17.3)::geography) AS dist 
FROM hyd_shops
WHERE name IS NOT NULL;

-- [Map Layer Query: Visual Data]
-- Used to load shops as a layer in QGIS with distance information.
SELECT 
    row_number() OVER () AS temp_id, 
    name, 
    geom, 
    ST_Distance(geom::geography, ST_MakePoint(78.4, 17.3)::geography) AS dist 
FROM hyd_shops 
WHERE name IS NOT NULL;


-- 2. ST_BUFFER ANALYSIS
---------------------------------------------------------

-- [General Query: Attribute Data]
-- Generates the geometry data for the buffer zone.
SELECT 
    ST_Buffer(ST_MakePoint(78.4, 17.3)::geography, 1000) AS buffer_area;

-- [Map Layer Query: Visual Data]
-- Creates a 1km circular search area to be visualized on the QGIS Map Canvas.
SELECT 
    1 AS id, 
    '1KM Search Zone' AS zone_name,
    ST_Buffer(ST_MakePoint(78.4, 17.3)::geography, 1000)::geometry AS geom;
