/* DAY 6: POSTGIS SPATIAL FUNCTIONS AND VISUALIZATION
   Topics Covered: ST_Area, ST_AsText, ST_MakeLine, and ST_Length.
   Objective: Learning the difference between Data retrieval (General Query) 
              and Spatial Visualization (Map Layer Query).
*/

-- =============================================================
-- 1. ST_Area: Calculating the surface area of Polygon geometries.
-- =============================================================

-- General Query: To see the area values in the result table.
SELECT   
    name AS shop_name, 
    ST_Area(geom) AS area_sq_meters 
FROM hyd_shops 
WHERE name IS NOT NULL
LIMIT 10;

-- (PostGIS) Map Layer Query: Including 'geom' to visualize shops on the map.
SELECT 
    id, 
    name, 
    ST_Area(geom) AS area_sq_meters,
    geom 
FROM hyd_shops 
WHERE name IS NOT NULL;


-- =============================================================
-- 2. ST_AsText: Converting binary geometry to readable coordinates (WKT).
-- =============================================================

-- General Query: To extract and read latitude/longitude values.
SELECT 
    id, 
    ST_AsText(geom) AS coordinates
FROM bike_points05
LIMIT 10;      

-- (PostGIS) Map Layer Query: Adding 'geom' to display point locations in QGIS.
SELECT 
    id, 
    geom,
    ST_AsText(geom) AS coordinates
FROM bike_points05
LIMIT 10;


-- =============================================================
-- 3. ST_MakeLine & ST_Length: Point-to-Line conversion and Measurement.
-- =============================================================

-- General Query: Logic to connect two points and calculate the distance.
SELECT 
    p1.id AS start_id,
    p2.id AS end_id,
    ST_MakeLine(p1.geom, p2.geom) AS geom,
    ST_Length(ST_MakeLine(p1.geom, p2.geom)::geography) AS length_meters
FROM bike_points05 p1, bike_points05 p2
WHERE p1.id != p2.id
LIMIT 1;

-- (PostGIS) Map Layer Query: Creating a Unique 'trip_id' for QGIS Layer rendering.
SELECT 
    p1.id || '-' || p2.id AS trip_id, 
    ST_MakeLine(p1.geom, p2.geom) AS geom, 
    ST_Length(ST_MakeLine(p1.geom, p2.geom)::geography) AS line_length_m 
FROM bike_points05 p1, bike_points05 p2 
WHERE p1.id != p2.id 
LIMIT 1;
