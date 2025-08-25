provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 40
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }

  service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  tags = ["http-server", "https-server", "test"]

}

resource "google_compute_firewall" "allow_http_https" {
  name    = "allow-http-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080", "9000", "3001", "7o80"]
  }

  source_ranges = ["10.0.10.0/30"]
  target_tags   = ["http-server", "https-server"]
}

# Output the external IP of the VM
output "instance_ip" {
  value = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}



output "instance_ip_1" {
  value = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}

output "instance_ip_2" {
  value = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}


resource "google_compute_Firewall" "allow_http_https_1" {
  name    = "allow-http-https_1"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080", "9000", "3001", "8080"]
  }

  # Please specify the intended source IP ranges for the firewall rule.
  source_ranges = ["172.10.0.0/24"]

  target_tags   = ["http-server_new", "https-server_new"]
}
