variable "gcp_project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "gcp_region" {
  description = "GCP Region"
  type        = string
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

variable "ip_cidr_range" {
  description = "Cluster CIDR IPs for Nodes, Pods, and Services. Each CIDR is represeted as, e.g., 10.10.0.0/20"
  type = object({
    public_subnet = string
    #gke_subnet    = string
  }) #when we create gke cluster, we will add configure another variable for that
}

variable "firewall_rules" {
  description = "List of firewall rules to be created"
  type = list(object({
    name = string
    allow = list(object({
      protocol = string
      ports    = optional(list(string))
    }))
    source_tags   = optional(list(string))
    source_ranges = optional(list(string))
    target_tags   = optional(list(string))
  }))
  default = []
}

variable "subnet_names" {
  description = "Names of the subnets in the vpc"
  type = object({
    public_subnet = string
    #gke_subnet    = string
  })

}
