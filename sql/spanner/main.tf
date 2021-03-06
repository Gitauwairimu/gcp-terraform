resource "google_spanner_instance" "instancespanner" {
    name = "instancespanner"
    config = "regional-europe-west1"
    display_name = "instancespanner"
    processing_units    = 200
    
    labels = {
    "env" = "learning"
  }
}

resource "google_spanner_database" "dbspanner" {
    name = "dbspanner"
    instance = google_spanner_instance.instancespanner.name
    deletion_protection = false

}