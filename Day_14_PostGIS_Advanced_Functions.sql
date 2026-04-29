-------------------------------------------------------------------------
-- DAY 14: PostGIS Advanced Analysis & Data Export Functions
-- Focus: Splitting, Projecting, Angles, and Formats
-------------------------------------------------------------------------

-- 1. ST_Split (Cutting Geometry)
-- Meaning: Divides one geometry into parts using another geometry (the blade).
-- Usecase: Useful for splitting road networks at intersections or dividing administrative boundaries.

-- General Query:
SELECT ST_AsText(ST_Split(
    ST_SetSRID(ST_MakeLine(ST_MakePoint(78.4, 17.3), ST_MakePoint(78.5, 17.3)), 4326), 
    ST_SetSRID(ST_MakePoint(78.45, 17.3), 4326)
));

-- Map Layer Query (QGIS Canvas Output):
-- Settings: Unique ID = id, Geometry = geom, Layer Name = Split_Line_3857
SELECT (row_number() OVER())::int AS id, 
       sub.geom::geometry(LineString, 3857) 
FROM (
    SELECT (ST_Dump(ST_Split(
        ST_Transform(ST_SetSRID(ST_MakeLine(ST_MakePoint(78.4, 17.3), ST_MakePoint(78.5, 17.3)), 4326), 3857), 
        ST_Transform(ST_SetSRID(ST_MakePoint(78.45, 17.3), 4326), 3857)
    ))).geom AS geom
) AS sub;

-------------------------------------------------------------------------

-- 2. ST_AsGeoJSON (Data Export)
-- Meaning: Converts a PostGIS geometry into a Web-standard JSON string.
-- Usecase: Exporting data for use in web mapping applications like Leaflet, OpenLayers, or Mapbox.

-- General Query:
SELECT ST_AsGeoJSON(ST_SetSRID(ST_MakePoint(78.4, 17.3), 4326));

-- Map Layer Query:
-- Settings: Unique ID = id, Geometry = geom, Layer Name = AsGeoJSON_Attribute_Layer
SELECT 
    1::int AS id, 
    ST_AsGeoJSON(ST_SetSRID(ST_MakePoint(78.4, 17.3), 4326)) AS geojson_text, 
    ST_Transform(ST_SetSRID(ST_MakePoint(78.4, 17.3), 4326), 3857)::geometry(Point, 3857) AS geom;

-------------------------------------------------------------------------

-- 3. ST_Azimuth (Angle Calculation)
-- Meaning: Returns the angle (in radians) between two points measured clockwise from North.
-- Usecase: Calculating the heading or direction of travel for moving objects (e.g., autonomous vehicles).

-- General Query:
SELECT degrees(ST_Azimuth(ST_MakePoint(78.4, 17.3), ST_MakePoint(78.5, 17.4)));

-- Map Layer Query:
-- Settings: Unique ID = id, Geometry = geom, Layer Name = Azimuth_Rectangle_Layer
SELECT 
    1::int AS id, 
    degrees(ST_Azimuth(ST_MakePoint(78.4, 17.3), ST_MakePoint(78.5, 17.4))) AS angle,
    ST_Transform(ST_MakeEnvelope(78.4, 17.3, 78.5, 17.4, 4326), 3857)::geometry AS geom;

-------------------------------------------------------------------------

-- 4. ST_GeometryType (Validation)
-- Meaning: Returns the specific geometry type (e.g., ST_Point, ST_LineString) of a geometry.
-- Usecase: Data validation to ensure a column contains the expected spatial types.

-- General Query:
SELECT ST_GeometryType(ST_SetSRID(ST_MakePoint(78.4, 17.3), 4326));

-- Map Layer Query:
-- Settings: Unique ID = id, Geometry = geom, Layer Name = Geometry_Type_Check_Layer
SELECT 1::int AS id, 
       ST_GeometryType(geom) AS type_name,
       ST_Transform(geom, 3857)::geometry AS geom
FROM (SELECT ST_SetSRID(ST_MakePoint(78.4, 17.3), 4326) AS geom) AS sub;

-------------------------------------------------------------------------

-- 5. ST_Project (Moving/Offsetting a Point)
-- Meaning: Returns a new point projected from a start point using a specific distance and azimuth (bearing).
-- Usecase: Calculating a target location based on a current position, speed, and heading.

-- General Query:
SELECT ST_AsText(ST_Project(
    ST_MakePoint(78.4, 17.3)::geography, 
    1000, 
    radians(45) 
));

-- Map Layer Query:
-- Settings: Unique ID = id, Geometry = geom, Layer Name = Projected_Target_Point
SELECT 1::int AS id, 
       ST_Transform(ST_Project(
           ST_MakePoint(78.4, 17.3)::geography, 
           500, 
           radians(90) 
       )::geometry, 3857)::geometry(Point, 3857) AS geom;

-------------------------------------------------------------------------
