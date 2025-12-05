# This file provisions a simple Google Cloud environment

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

# Google provider
provider "google" {

  project = "core-dev"
  region  = "europe-west1"
  zone    = "europe-west1-c"
}

# Creates a simple custom VPC network for our instances
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

# Static IP address attached to the primary compute instance
resource "google_compute_address" "vm_static_ip" {
  name = "terraform-static-ip"
}

# Primary compute instance
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"
  
  # Boot disk configuration
  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  # Network interface configuration
  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
      nat_ip = google_compute_address.vm_static_ip.address
    }
  }

  tags = ["web", "dev"]

  # Local exec provisioner
  provisioner "local-exec" {
    command = "echo ${google_compute_instance.vm_instance.name}:  ${google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip} >> ip_address.txt"
  }
}

# Storage bucket
resource "google_storage_bucket" "vm_bucket" {
  name     = "ikenna_2025"
  location = "US"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

# Create a new instance that uses the bucket
resource "google_compute_instance" "second_instance" {
  depends_on = [google_storage_bucket.vm_bucket]

  name         = "terraform-instance-2"
  machine_type = "e2-micro"

  # Boot disk configuration
  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  # Network interface configuration
  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
}
