Collecting workspace information

```markdown
# Data Engineering Journey

This repository contains my homework, assignments, and projects for the Data Engineering Zoomcamp. It documents my learning journey in data engineering, covering topics like data ingestion, transformation, and pipeline orchestration.

## Questions and Answers

### Question 1
**Run docker with the python:3.12.8 image in an interactive mode, use the entrypoint bash.**

**Answer (Code):**
```sh
docker run -it --entrypoint bash python:3.12.8
```
**Version:** 24.3.1

### Question 2
**Answer:** db:5432

### Question 3
**Answer:**
```sql
SELECT
    COUNT(CASE WHEN trip_distance <= 1 THEN 1 END) AS up_to_1_mile,
    COUNT(CASE WHEN trip_distance > 1 AND trip_distance <= 3 THEN 1 END) AS between_1_and_3_miles,
    COUNT(CASE WHEN trip_distance > 3 AND trip_distance <= 7 THEN 1 END) AS between_3_and_7_miles,
    COUNT(CASE WHEN trip_distance > 7 AND trip_distance <= 10 THEN 1 END) AS between_7_and_10_miles,
    COUNT(CASE WHEN trip_distance > 10 THEN 1 END) AS more_than_10_miles
FROM
    green_tripdata;
FROM
    green_tripdata
WHERE
    lpep_pickup_datetime >= '2019-10-01' AND lpep_pickup_datetime < '2019-11-01'
    AND trip_distance IS NOT NULL;  -- Ensure trip_distance is not NULL
    
```
104830	198995	109642	27686	35201

### Question 4. Longest trip for each day
**Answer:**
```sql
SELECT
    DATE(lpep_pickup_datetime) AS pickup_date,
    MAX(trip_distance) AS longest_trip_distance
FROM
    green_tripdata
GROUP BY
    DATE(lpep_pickup_datetime)
ORDER BY
    longest_trip_distance DESC
LIMIT 1;
```

Output 2019-10-31

### Question 5. Three biggest pickup zones
***Answer***

```sql
SELECT
    tzl."Zone",
    SUM(gtd.total_amount) AS total_amount
FROM
    green_tripdata gtd
JOIN
    zone_lookup tzl ON gtd."PULocationID" = tzl."LocationID"
WHERE
    DATE(gtd.lpep_pickup_datetime) = '2019-10-18'
GROUP BY
    tzl."Zone"
HAVING
    SUM(gtd.total_amount) > 13000
ORDER BY
    total_amount DESC;
```

**Result:**
- "East Harlem North"
- "East Harlem South"
- "Morningside Heights"

### Question 6
**Answer:**
```sql
SELECT
    dzl."Zone" AS dropoff_zone,
    MAX(gtd.tip_amount) AS largest_tip
FROM
    green_tripdata gtd
JOIN
    zone_lookup pzl ON gtd."PULocationID" = pzl."LocationID"
JOIN
    zone_lookup dzl ON gtd."DOLocationID" = dzl."LocationID"
WHERE
    pzl."Zone" = 'East Harlem North'
    AND gtd.lpep_pickup_datetime >= '2019-10-01'
    AND gtd.lpep_pickup_datetime < '2019-11-01'
GROUP BY
    dzl."Zone"
ORDER BY
    largest_tip DESC
LIMIT 1;
```
**Result:**
- JFK Airport 87.3
```