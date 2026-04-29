-- ==========================================
DAY 15: PostGIS Spatial Relationships, Geometry Construction & Cleaning
-- 1. ST_Contains (Spatial Relationship)
-- Use Case: Check if a point is inside a polygon boundary.
-- ==========================================

-- General Query
SELECT ST_Contains(
    ST_MakeEnvelope(0, 0, 10, 10, 4326), 
    ST_SetSRID(ST_MakePoint(5, 5), 4326) 
);

-- Map Layer Query
SELECT 1::int AS id, 
       ST_Transform(geom, 3857)::geometry AS geom 
FROM (SELECT ST_MakeEnvelope(78.4, 17.3, 78.5, 17.4, 4326) AS geom) AS sub 
WHERE ST_Contains(geom, ST_SetSRID(ST_MakePoint(78.45, 17.35), 4326));


-- ==========================================
-- 2. ST_Intersection (Common Area)
-- Use Case: Finding the overlapping area of two shapes.
-- ==========================================

-- General Query
SELECT ST_AsText(ST_Intersection(
    ST_MakeEnvelope(0, 0, 2, 2, 4326), 
    ST_MakeEnvelope(1, 1, 3, 3, 4326)
));

-- Map Layer Query
SELECT 1::int AS id, 
       ST_Transform(
           ST_Intersection(
               ST_MakeEnvelope(78.4, 17.3, 78.5, 17.4, 4326), 
               ST_MakeEnvelope(78.45, 17.35, 78.55, 17.45, 4326)
           ), 3857
       )::geometry AS geom;


-- ==========================================
-- 3. ST_Envelope (Bounding Box Polygon)
-- Use Case: Generating a rectangle that encloses a geometry.
-- ==========================================

-- General Query
SELECT ST_AsText(ST_Envelope(
    ST_GeomFromText('LINESTRING(0 0, 1 5, 2 0)', 4326)
));

-- Map Layer Query
SELECT 1::int AS id, 
       ST_Transform(
           ST_Envelope(ST_SetSRID(ST_MakeLine(ST_MakePoint(78.4, 17.3), ST_MakePoint(78.5, 17.5)), 4326)), 
           3857
       )::geometry AS geom;


-- ==========================================
-- 4. ST_SnapToGrid (Data Cleaning)
-- Use Case: Aligning coordinates to a grid to fix digitizing errors.
-- ==========================================

-- General Query
SELECT ST_AsText(ST_SnapToGrid(
    ST_SetSRID(ST_MakePoint(78.4111, 17.3111), 4326), 
    0.1
));

-- Map Layer Query
SELECT 1::int AS id, 
       ST_Transform(
           ST_SnapToGrid(ST_SetSRID(ST_MakePoint(78.4111, 17.3111), 4326), 0.1), 
           3857
       )::geometry(Point, 3857) AS geom;


-- ==========================================
-- 5. ST_PointOnSurface (Safe Center)
-- Use Case: Finding a point inside an irregular polygon for labeling.
-- ==========================================

-- General Query
SELECT ST_AsText(ST_PointOnSurface(
    ST_MakeEnvelope(78.4, 17.3, 78.5, 17.4, 4326)
));

-- Map Layer Query
SELECT 1::int AS id, 
       ST_Transform(
           ST_PointOnSurface(ST_MakeEnvelope(78.4, 17.3, 78.5, 17.4, 4326)), 
           3857
       )::geometry AS geom;


-- ==========================================
-- 6. ST_BBox / Box2D (Bounding Box Extent)
-- Use Case: Rapidly calculating the coordinate limits of a feature.
-- ==========================================

-- General Query
SELECT Box2D(ST_SetSRID(ST_MakeLine(ST_MakePoint(78.4, 17.3), ST_MakePoint(78.5, 17.5)), 4326));

-- Map Layer Query
SELECT 1::int AS id, 
       ST_Transform(
           ST_SetSRID(
               Box2D(ST_SetSRID(ST_MakeLine(ST_MakePoint(78.4, 17.3), ST_MakePoint(78.5, 17.5)), 4326))::geometry, 
               4326
           ), 
           3857
       )::geometry AS geom;
