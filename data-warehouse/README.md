## 1 Create a Regular Table from the External Table

```sql
CREATE OR REPLACE EXTERNAL TABLE `ordinal-nectar-304400.zoomcamp_ds.yellow_taxi_external`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://ordinal-nectar-304400/data-warehouse/yellow_tripdata_2024-0[1-6].parquet']
);

```

```sql
CREATE OR REPLACE TABLE `ordinal-nectar-304400.zoomcamp_ds.yellow_taxi_table`
AS
SELECT * FROM `ordinal-nectar-304400.zoomcamp_ds.yellow_taxi_external`;

```

```sql
CREATE MATERIALIZED VIEW `ordinal-nectar-304400.zoomcamp_ds.yellow_taxi_materialized`
AS
SELECT * FROM `ordinal-nectar-304400.zoomcamp_ds.yellow_taxi_external`;
```

## Question 1: What is count of records for the 2024 Yellow Taxi Data?

## Answer:
```sql
SELECT COUNT(*) AS total_records
FROM `your_project_id.dataset_name.yellow_taxi_external`;
```

## Question 2: Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.
## What is the estimated amount of data that will be read when this query is executed on the External Table and the Table?

## Answer

```sql
SELECT COUNT(DISTINCT PULocationID) AS distinct_pulocations_external
FROM `ordinal-nectar-304400.zoomcamp_ds.yellow_taxi_external`;

SELECT COUNT(DISTINCT PULocationID) AS distinct_pulocations_external
FROM `ordinal-nectar-304400.zoomcamp_ds.yellow_taxi_external`;
```
## Qustion 3: Write a query to retrieve the PULocationID from the table (not the external table) in BigQuery.
## Now write a query to retrieve the PULocationID and ##DOLocationID on the same table. Why are the estimated number of Bytes different?

## Answer

```sql
SELECT PULocationID 
FROM `ordinal-nectar-304400.zoomcamp_ds.yellow_taxi_table`;

SELECT PULocationID, DOLocationID 
FROM `ordinal-nectar-304400.zoomcamp_ds.yellow_taxi_table`;
```

## "BigQuery is a columnar database, and it only scans the specific columns requested in the query. Querying two columns (PULocationID, DOLocationID) requires reading ## more data than querying one column (PULocationID), leading to a higher estimated number of bytes processed."

## Question 4: How many records have a fare_amount of 0?

## Answer

```sql
SELECT COUNT(*) AS zero_fare_trips
FROM `ordinal-nectar-304400.zoomcamp_ds.yellow_taxi_table`
WHERE fare_amount = 0;
```

## Question 5: What is the best strategy to make an optimized table in Big Query if your query will always filter based on tpep_dropoff_datetime and order the results ## by VendorID (Create a new table with this strategy)

## Answer

## Partition by tpep_dropoff_datetime and Cluster on VendorID

```sql
CREATE OR REPLACE TABLE `ordinal-nectar-304400.zoomcamp_ds.optimized_yellow_taxi_table`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID AS
SELECT * FROM `ordinal-nectar-304400.zoomcamp_ds.yellow_taxi_table`;
```

## Question 6 Write a query to retrieve the distinct VendorIDs between tpep_dropoff_datetime 2024-03-01 and 2024-03-15 (inclusive)
## Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table in the from clause to the partitioned table you ## created for question 5 and note the estimated bytes processed. What are these values?
                                        
# Answer
# Using materialised table

```sql
SELECT DISTINCT VendorID
FROM `ordinal-nectar-304400.zoomcamp_ds.yellow_taxi_materialized`
WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' AND '2024-03-15';
```
# Using the partitioned table

```sql
SELECT DISTINCT VendorID
FROM `ordinal-nectar-304400.zoomcamp_ds.optimized_yellow_taxi_table`
WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' AND '2024-03-15';
```

## Question 7: Where is the data stored in the External Table you created?

## Answer: GCP Bucket

## Question 8: It is best practice in Big Query to always cluster your data:

## Answer: False

### Need to add the query results for 1 to 6 