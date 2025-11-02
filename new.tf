resource "google_compute_instance" "vm_pl" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size   = 40
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
  }

  service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  tags = ["http-server", "https-server", "test"]

}.


