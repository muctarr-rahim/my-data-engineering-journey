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

```
### Question 7 Terraform Workflow

```sh
gcloud auth application-default login
```
```sh
export GOOGLE_APPLICATION_CREDENTIALS="path/to/service-account-key.json"
```

***Answer**
***This file configures the backend to store the Terraform state file in a GCS bucket. backend.tf***



```sh
terraform {
  backend "gcs" {
    bucket = "my-terraform-state-bucket"  
    prefix = "terraform/state"           
  }
}
```

***This file configures the GCP provider and specifies the project and region provider.tf***

```sh
provider "google" {
  project = var.gcp_project  
  region  = var.region
}
```

***This file defines input variables for the GCP project ID and region variables.tf.***

```sh
variable "gcp_project" {
  description = "The GCP project ID"
  type        = string
  default     = "my-gcp-project"  
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "gcs_bucket_name" {
  description = "The name of the GCS bucket"
  type        = string
  default     = "my-terraform-bucket"  
}

variable "bigquery_dataset_name" {
  description = "The name of the BigQuery dataset"
  type        = string
  default     = "my_bigquery_dataset"  
}
```

***This file defines the resources: a GCS bucket and a BigQuery dataset main.tf.***

```sh
resource "google_storage_bucket" "default" {
  name          = var.gcs_bucket_name
  location      = var.region
  force_destroy = true 

  labels = {
    environment = "dev"
  }
}

resource "google_bigquery_dataset" "default" {
  dataset_id = var.bigquery_dataset_name
  location   = var.region

  labels = {
    environment = "dev"
  }
}
```

***This file defines output values to display after applying the configuration output.tf.***

```sh
output "gcs_bucket_name" {
  description = "The name of the created GCS bucket"
  value       = google_storage_bucket.default.name
}

output "bigquery_dataset_name" {
  description = "The name of the created BigQuery dataset"
  value       = google_bigquery_dataset.default.dataset_id
}
```

***Workflow commands***

***1 Initialise:***
```sh
terraform init
```

***2 Plan:***
```Sh
terraform plan
```

***Apply:***
```sh
terraform apply -auto-approve
```
***Destroy:***
```sh
terraform destroy -auto-approve





