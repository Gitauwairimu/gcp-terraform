resource "google_storage_bucket" "storegcp-terraform-bucket" {
  name          = "storegcp-terraform-bucket"
  location      = "EU"
  force_destroy = true

  labels = {
    "env" = "dev"
  }

  lifecycle_rule {
    condition {
      age = 4
    }
    action {
      type = "Delete"
    }
  }
}


resource "google_storage_bucket" "expiry-storegcp-terraform-bucket" {
  name = "expiry-storegcp-terraform-bucket"
  location      = "US"
  force_destroy = true
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
        created_before = "2021-10-06"
    }

    action {
        type = "SetStorageClass"
        storage_class = "ARCHIVE"
    }
  }
}