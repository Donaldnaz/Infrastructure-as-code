# ─────────────────────────────────────────────
# Project / Region
# ─────────────────────────────────────────────
variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region (must support Cloud Run GPUs)"
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "Deployment environment (dev | staging | prod | verse-dev)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod", "verse-dev"], var.environment)
    error_message = "environment must be one of: dev, staging, prod, verse-dev."
  }
}

variable "team" {
  description = "Team label applied to all resources"
  type        = string
  default     = "ml-platform"
}

# ─────────────────────────────────────────────
# Artifact Registry
# ─────────────────────────────────────────────
variable "repository_id" {
  description = "Artifact Registry repository ID"
  type        = string
}

# ─────────────────────────────────────────────
# GCS Model Bucket
# ─────────────────────────────────────────────
variable "model_bucket_name" {
  description = "GCS bucket name that stores model artifacts"
  type        = string
}

# ─────────────────────────────────────────────
# Cloud Run Service
# ─────────────────────────────────────────────
variable "service_name" {
  description = "Cloud Run service name"
  type        = string
}

variable "image_name" {
  description = "Docker image name (without registry prefix)"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
  default     = "latest"
}

variable "gpu_type" {
  description = "GPU accelerator type (e.g. nvidia-l4, nvidia-a100-80gb)"
  type        = string
  default     = "nvidia-l4"
}

variable "gpu_count" {
  description = "Number of GPUs to attach"
  type        = number
  default     = 1
}

variable "cpu" {
  description = "vCPU allocation for the container"
  type        = string
  default     = "8"
}

variable "memory" {
  description = "Memory allocation for the container"
  type        = string
  default     = "32Gi"
}

variable "min_instances" {
  description = "Minimum number of Cloud Run instances (use 1+ in prod to avoid cold starts)"
  type        = number
  default     = 0
}

variable "max_instances" {
  description = "Maximum number of Cloud Run instances"
  type        = number
  default     = 3
}

variable "allow_public_access" {
  description = "Whether to allow unauthenticated (public) invocations"
  type        = bool
  default     = false
}

variable "extra_env_vars" {
  description = "Additional environment variables to inject into the container"
  type        = map(string)
  default     = {}
}

variable "request_timeout" {
  description = "Max request duration (e.g. 300s). GPU inference can be slow."
  type        = string
  default     = "300s"
}

variable "concurrency" {
  description = "Max concurrent requests per instance"
  type        = number
  default     = 1
}
