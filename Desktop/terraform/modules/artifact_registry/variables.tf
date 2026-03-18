variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region for the repository"
  type        = string
}

variable "repository_id" {
  description = "Artifact Registry repository ID"
  type        = string
}

variable "description" {
  description = "Human-readable description for the repository"
  type        = string
  default     = "Docker image repository"
}

variable "cloud_run_sa_email" {
  description = "Service account email that Cloud Run uses (granted reader role)"
  type        = string
}

variable "labels" {
  description = "Labels to apply to the repository"
  type        = map(string)
  default     = {}
}
