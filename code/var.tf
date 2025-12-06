# Infrastructure Variables

variable "region" {
  type        = string
  description = "Region for the resource."
}

variable "location" {
  type        = string
  description = "zone for the resource."
}

variable "network_name" {
  default = "tf-gke-k8s"
}
