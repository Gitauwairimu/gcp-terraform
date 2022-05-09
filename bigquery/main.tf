resource "google_bigquery_dataset" "bqdataset" {
    dataset_id = "bqdataset"
    location = "US"
    description = "Nairobi Traffic Dataset description"
    friendly_name = "bqdataset"
  
}