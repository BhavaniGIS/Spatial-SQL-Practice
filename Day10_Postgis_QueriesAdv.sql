-- Day 10: Advanced PostGIS Spatial Commands
-- Purpose: Practicing Point Creation and Fast Proximity Searching.

-- 1. ST_SetSRID (Assigning Spatial Reference)
-- General query: To see the point in readable Text (WKT) format.
SELECT ST_AsText(ST_SetSRID(ST_MakePoint(78.47, 17.36), 4326));

-- Map layer query: To render the point on the QGIS map as a geometry.
SELECT 1 AS id, ST_SetSRID(ST_MakePoint(78.47, 17.36), 4326)::geometry AS geom;


-- 2. ST_DWithin (Proximity / Radius Search)
-- General Query: Finding the names of shops within 2000 meters of a point.
SELECT name FROM "hyd_shops" 
WHERE ST_DWithin(geom::geography, ST_MakePoint(78.47, 17.36)::geography, 2000);

-- Map layer query: Loading the nearby shops as polygons on the QGIS map.
SELECT id, name, geom FROM "hyd_shops" 
WHERE ST_DWithin(geom::geography, ST_MakePoint(78.47, 17.36)::geography, 2000);
