# my-data-engineering-journey
# Data Engineering Journey

This repository contains the code and documentation for my data engineering journey.

## Questions and Answers

### Question 6:
**For the passengers picked up in October 2019 in the zone named "East Harlem North", which was the drop-off zone that had the largest tip?**

**Options:**
- Yorkville West
- JFK Airport
- East Harlem North
- East Harlem South

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