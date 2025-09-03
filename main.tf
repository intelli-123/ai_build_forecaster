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

}

resource "google_compute_firewall" "allow_http_https" {
  name    = "allow-http-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "9000", "3001"]
  }


  source_ranges = var.allow_http_https_source_ranges
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

  source_ranges = var.allow_http_https_1_source_ranges

  target_tags   = ["http-server_new", "https-server_new"]
}

variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "region" {
  description = "The GCP region for resources."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone for the VM instance."
  type        = string
  default     = "us-central1-a"
}

variable "vm_name" {
  description = "Name of the VM instance."
  type        = string
  default     = "my-app-vm"
}

variable "machine_type" {
  description = "Machine type for the VM instance."
  type        = string
  default     = "e2-medium"
}

variable "service_account_email" {
  description = "Email of the service account to attach to the VM."
  type        = string
}

variable "allow_http_https_source_ranges" {
  description = "List of IP CIDR ranges that are allowed to access HTTP/HTTPS services on the VM for the 'allow-http-https' firewall rule. Replace with specific IPs/networks, e.g., [\"203.0.113.0/24\"]. Avoid '0.0.0.0/0' for production environments."
  type        = list(string)
  # No default to force user to specify specific ranges.
}

variable "allow_http_https_1_source_ranges" {
  description = "List of IP CIDR ranges that are allowed to access HTTP/HTTPS services on the VM for the 'allow-http-https_1' firewall rule. Replace with specific IPs/networks, e.g., [\"203.0.113.0/24\"]. Avoid '0.0.0.0/0' for production environments."
  type        = list(string)
  # No default to force user to specify specific ranges.
}

variable "firewall_port_44e" {
  description = "Ask the user to provide a valid protocol (tcp, udp, icmp, esp, ah, sctp, ipip) for the firewall rule."
  type        = string
  }

variable "firewall_port_7080" {
  description = "The firewall port 7080."
  type        = number
}