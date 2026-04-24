/* PostGIS Learning Journey - Day 8
   Topic: ST_Union and ST_GeomFromText 
   Concepts: Creating combined buffers and manual geometry points.
*/

-----------------------------------------------------------
-- 1. ST_Union: Merging Multiple Buffer Zones
-----------------------------------------------------------

-- A. General Query (DB Manager / Analytics)
-- Use Case: To calculate or visualize a single combined area from two different points.
SELECT ST_Union(
    ST_Buffer(ST_MakePoint(78.4, 17.3)::geography, 500)::geometry, 
    ST_Buffer(ST_MakePoint(78.45, 17.35)::geography, 500)::geometry
) AS combined_area;

-- B. Map Layer Query (Virtual Layer / Filter)
-- Use Case: To display a "Combined Interest Zone" as a physical layer on the QGIS map.
SELECT 
    1 AS id, 
    'Combined Zone' AS name,
    ST_Union(
        ST_Buffer(ST_MakePoint(78.40, 17.30)::geography, 1000)::geometry, 
        ST_Buffer(ST_MakePoint(78.41, 17.31)::geography, 1000)::geometry
    ) AS geom;



-----------------------------------------------------------
-- 2. ST_GeomFromText: Creating Geometry from Coordinates
-----------------------------------------------------------

-- A. General Query (DB Manager)
-- Use Case: To append a manually defined location to an existing list of shops using UNION ALL.
SELECT name, geom FROM hyd_shops
UNION ALL
SELECT 'My Manual Shop' AS name, ST_GeomFromText('POINT(78.45 17.40)', 4326) AS geom;

-- B. Map Layer Query (Virtual Layer)
-- Use Case: To create a specific reference point (e.g., Charminar) without having a physical file.
SELECT 
    1 AS id, 
    'Charminar Area Point' AS name, 
    ST_GeomFromText('POINT(78.4744 17.3616)', 4326) AS geom;



-----------------------------------------------------------
-- SUMMARY OF COMMANDS (DAY 8)
-----------------------------------------------------------
/*
   * ST_Union: [Advanced] Merges two or more geometries into one. 
     Used for dissolving boundaries or combining service areas.
     
   * ST_GeomFromText: [Basic/Intermediate] Converts a text string (WKT) 
     into a spatial object the computer can map.
     
   * ST_Buffer: [Intermediate] Creates a radius or "zone" around a geometry.
   
   * ST_MakePoint: [Basic] Generates a point from X and Y coordinates.
*/
