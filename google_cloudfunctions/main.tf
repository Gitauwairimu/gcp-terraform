resource "google_storage_bucket" "cloud-functions-bucket234" {
  name     = "cloud-functions-bucket234"
  location = "US"
}

resource "google_storage_bucket_object" "nodejs-app-archive" {
  name   = "index.zip"
  bucket = google_storage_bucket.cloud-functions-bucket234.name
  source = "chat-app-master.zip"
}


resource "google_cloudfunctions_function" "func-gcp-nodejs" {
  name        = "func-gcp-nodejs"
  description = "Random App Function"
  runtime     = "nodejs14"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.cloud-functions-bucket234.name
  source_archive_object = google_storage_bucket_object.nodejs-app-archive.name
  trigger_http          = true
  entry_point           = "helloGET"

  service_account_email = "terraform@pork-merchant.iam.gserviceaccount.com"
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.func-gcp-nodejs.project
  region         = google_cloudfunctions_function.func-gcp-nodejs.region
  cloud_function = google_cloudfunctions_function.func-gcp-nodejs.name

  role   = "roles/cloudfunctions.invoker"
  member = "user:terraform@pork-merchant.iam.gserviceaccount.com"
  #member = "allUsers"
}