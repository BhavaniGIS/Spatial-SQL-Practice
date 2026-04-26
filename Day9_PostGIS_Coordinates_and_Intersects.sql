/* PostGIS Learning Journey - Day 9 
   Topic: Coordinate Extraction (ST_X/ST_Y) and Spatial Intersects
   Focus: Numeric Data Extraction vs. Visual Map Layer Filtering
*/

-----------------------------------------------------------
-- 1. COORDINATE EXTRACTION (Turning Geometry into Numbers)
-----------------------------------------------------------

-- A. Extracting coordinates from Bike Points (Point Geometry)
-- Logic: Pulls X/Y directly. Useful for CSV/Excel exports.
SELECT id, 
       ST_X(geom) AS Lon_X, 
       ST_Y(geom) AS Lat_Y 
FROM "bike_points05" 
LIMIT 5;

-- B. Extracting coordinates from Shop Polygons (MultiPolygon Geometry)
-- Logic: Must use ST_Centroid first because Polygons don't have a single X/Y point.
SELECT 
    name, 
    ST_X(ST_Centroid(geom)) AS lon, 
    ST_Y(ST_Centroid(geom)) AS lat
FROM "hyd_shops";

-----------------------------------------------------------
-- 2. GENERAL QUERY (Data Table / Reporting)
-----------------------------------------------------------
-- Goal: List shop names and their coordinates within 500m of a point.
-- Result: Returns a text table (No shapes on map).

SELECT 
    name, 
    ST_X(ST_Centroid(geom)) AS Lon_X, 
    ST_Y(ST_Centroid(geom)) AS Lat_Y
FROM "hyd_shops" 
WHERE ST_Intersects(
    geom, 
    ST_Buffer(ST_GeomFromText('POINT(78.47 17.36)', 4326)::geography, 500)::geometry
);

-----------------------------------------------------------
-- 3. MAP LAYER QUERY (Spatial Visualization)
-----------------------------------------------------------
-- Goal: Filter and display only the shops inside the 500m buffer on the QGIS map.
-- Requirement: The 'geom' column must be included to render shapes.

SELECT 
    id, 
    name, 
    geom   
FROM "hyd_shops" 
WHERE ST_Intersects(
    geom, 
    ST_Buffer(ST_GeomFromText('POINT(78.47 17.36)', 4326)::geography, 500)::geometry
);
