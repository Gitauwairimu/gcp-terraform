resource "google_pubsub_topic" "readers" {
  name = "readers"
}


resource "google_pubsub_subscription" "readers-subscription" {
  name  = "readers-subscription"
  topic = google_pubsub_topic.readers.name

  ack_deadline_seconds = 20

  labels = {
    env = "dev"
  }

}