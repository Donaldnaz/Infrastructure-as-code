variable "gcp_project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "terraform_sa_email" {
  description = "Email of the Terraform service account"
  type        = string
}

variable "cloudrun_sa_email" {
  description = "Email of the Cloud Run service account"
  type        = string
}

variable "function_sa_email" {
  description = "Email of the Cloud Functions service account"
  type        = string
}

/*
variable "gke_sa_email" {
  description = "Email of the GKE service account"
  type        = string
}
*/