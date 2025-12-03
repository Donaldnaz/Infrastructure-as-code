resource "google_compute_network" "private_network" {
  name                    = var.vpc_name
  project                 = var.gcp_project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public_subnet" {

  #Check if there is a need for a gateway route  to make this subnet public

  name                     = "${var.subnet_names.public_subnet}-subnet"
  description              = "Public subnet for the VPC"
  ip_cidr_range            = var.ip_cidr_range.public_subnet
  project                  = var.gcp_project_id
  region                   = var.gcp_region
  network                  = google_compute_network.private_network.id
  private_ip_google_access = true
  # dynamic "log_config" {
  #   for_each = var.vpc_flow_log_enable == true ? [1] : []
  #   content {
  #     flow_sampling = 1.0
  #     metadata      = "INCLUDE_ALL_METADATA"
  #   }
  # }
}

/*
resource "google_compute_subnetwork" "gke_subnet" {
  name                     = "${var.subnet_names.gke_subnet}-subnet"
  description              = "private subnet for gke"
  ip_cidr_range            = var.ip_cidr_range.gke_subnet
  project                  = var.gcp_project_id
  region                   = var.gcp_region
  network                  = google_compute_network.private_network.id
  private_ip_google_access = true
  # dynamic "log_config" {
  #   for_each = var.vpc_flow_log_enable == true ? [1] : []
  #   content {
  #     flow_sampling = 1.0
  #     metadata      = "INCLUDE_ALL_METADATA"
  #   }
  # }
}
*/

resource "google_compute_router" "router" {

  name    = "vpc-router-${var.vpc_name}"
  project = var.gcp_project_id
  region  = google_compute_subnetwork.public_subnet.region
  network = google_compute_network.private_network.id

  bgp {
    asn = 64514
  }
}


resource "google_compute_firewall" "rules" {
  count   = length(var.firewall_rules)
  name    = var.firewall_rules[count.index].name
  network = google_compute_network.private_network.id

  dynamic "allow" {
    for_each = var.firewall_rules[count.index].allow
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  source_tags   = var.firewall_rules[count.index].source_tags
  source_ranges = var.firewall_rules[count.index].source_ranges
  # target_tags   = var.firewall_rules[count.index].target_tags
}
