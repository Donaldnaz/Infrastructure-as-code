variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "bucket_name" {
  description = "Globally unique GCS bucket name"
  type        = string
}

variable "location" {
  description = "GCS bucket location (region or multi-region)"
  type        = string
}

variable "force_destroy" {
  description = "Allow bucket deletion even if it contains objects (set false for prod)"
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Enable object versioning for model rollback support"
  type        = bool
  default     = true
}

variable "versions_to_keep" {
  description = "Number of non-current versions to retain before deletion"
  type        = number
  default     = 3
}

variable "cloud_run_sa_email" {
  description = "Service account email that Cloud Run uses (granted objectViewer role)"
  type        = string
}

variable "labels" {
  description = "Labels to apply to the bucket"
  type        = map(string)
  default     = {}
}
