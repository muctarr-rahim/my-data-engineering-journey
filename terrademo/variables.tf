
variable "credientails" {
  description = "My credientials"
  default     = "./keys/mycreds.json"

}

variable "gcp_project" {
  description = "The GCP project ID"
  default     = "ordinal-nectar-304400"
}

variable "region" {
  description = "The GCP region"
  default     = "us-central1"
}

variable "location" {
  description = "The GCS bucket location"
  default     = "US"

}

variable "gcs_bucket_name" {
  description = "Zoomcamp storage bucket name"
  default     = "ordinal-nectar-304400-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Zoomcamp GCS storage class"
  default     = "STANDARD"

}
variable "bigquery_dataset_name" {
  description = "The name of the BigQuery dataset"
  default     = "zoomcamp_ds"
}