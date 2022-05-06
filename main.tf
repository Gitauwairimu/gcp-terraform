resource "google_compute_network" "bq" {
  name                    = "bq"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "bqsubnet1" {
    name = "bqsubnet1"
    network = google_compute_network.bq.id
    private_ip_google_access  = true
    ip_cidr_range = "10.0.0.0/24"
      
}

resource "google_compute_firewall" "allow_80" {
  name = "allow-80"
  source_ranges = ["0.0.0.0/0"]
  network = google_compute_network.bq.id
  allow {
    protocol = "tcp"
    ports = ["80"]
  }
    
}

resource "google_compute_disk" "disklots" {
  name  = "disklots"
  type  = "pd-ssd"
  size  = "10"
  physical_block_size_bytes = 4096
  zone = "us-central1-a"
  labels = {
    env = "test"
  }
  
}

resource "google_compute_attached_disk" "attachdisk" {
  disk     = google_compute_disk.disklots.id
  instance = google_compute_instance.utilityvm .id
}

resource "google_compute_instance" "utilityvm" {
  name  = "utilityvm"

  machine_type = "f1-micro"
  zone         = "us-central1-a"

  tags = ["test", "vm"]

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = "10"               
      type  = "pd-standard"
      
      
    }
    auto_delete = true
  }


  scheduling {
    preemptible = false
    automatic_restart = false
    on_host_maintenance = "migrate"
  }



  network_interface {
    network = google_compute_network.bq.id
    subnetwork = google_compute_subnetwork.bqsubnet1.id

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "terraform@pork-merchant.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  lifecycle {
    ignore_changes = [ 
      attached_disk
      ]
  }
}