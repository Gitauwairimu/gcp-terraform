resource "google_bigquery_dataset" "bqdataset" {
    dataset_id = "bqdataset"
    location = "US"
    description = "Nairobi Traffic Dataset description"
    friendly_name = "bqdataset"
  
}

resource "google_bigquery_table" "bttable" {
  dataset_id = google_bigquery_dataset.bqdataset.dataset_id
  table_id   = "bar"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = "default"
  }

deletion_protection=false
  
  schema = <<EOF
[
  {
    "name": "permalink",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "The Permalink"
  },
  {
    "name": "state",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "State where the head office is located"
  }
]
EOF
}

resource "google_bigquery_table" "bqsheet" {
  dataset_id = google_bigquery_dataset.bqdataset.dataset_id
  table_id   = "bar"

  external_data_configuration {
    autodetect    = true
    source_format = "GOOGLE_SHEETS"

    google_sheets_options {
      skip_leading_rows = 1
    }

    source_uris = [
      "https://docs.google.com/spreadsheets/d/123456789012345",
    ]
  }
}