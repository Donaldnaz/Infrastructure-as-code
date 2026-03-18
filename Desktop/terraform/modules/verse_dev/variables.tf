variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region for the Cloud Run service"
  type        = string
}

variable "service_name" {
  description = "Cloud Run service name"
  type        = string
}

variable "service_account_email" {
  description = "Service account email the Cloud Run service runs as"
  type        = string
}

variable "image" {
  description = "Full Docker image URI including tag"
  type        = string
}

# ─── GPU ─────────────────────────────────────
variable "gpu_type" {
  description = "GPU accelerator type (nvidia-l4 | nvidia-a100-80gb | nvidia-tesla-t4)"
  type        = string
  default     = "nvidia-l4"

  validation {
    condition     = contains(["nvidia-l4", "nvidia-a100-80gb", "nvidia-tesla-t4"], var.gpu_type)
    error_message = "gpu_type must be one of: nvidia-l4, nvidia-a100-80gb, nvidia-tesla-t4."
  }
}

variable "gpu_count" {
  description = "Number of GPUs to attach (0 to disable GPU)"
  type        = number
  default     = 1
}

# ─── Compute ─────────────────────────────────
variable "cpu" {
  description = "vCPU allocation"
  type        = string
  default     = "8"
}

variable "memory" {
  description = "Memory allocation (e.g. 32Gi)"
  type        = string
  default     = "32Gi"
}

# ─── Scaling ─────────────────────────────────
variable "min_instances" {
  description = "Minimum instances (use 1+ in prod to avoid GPU cold starts)"
  type        = number
  default     = 0
}

variable "max_instances" {
  description = "Maximum instances"
  type        = number
  default     = 3
}

variable "concurrency" {
  description = "Max concurrent requests per instance (1 recommended for GPU inference)"
  type        = number
  default     = 1
}

# ─── Request handling ────────────────────────
variable "request_timeout" {
  description = "Max request duration (GPU inference can be slow)"
  type        = string
  default     = "300s"
}

variable "health_check_path" {
  description = "HTTP path for startup and liveness probes"
  type        = string
  default     = "/health"
}

variable "startup_probe_initial_delay" {
  description = "Seconds to wait before first startup probe (allow time for model load)"
  type        = number
  default     = 30
}

# ─── Access ──────────────────────────────────
variable "allow_public_access" {
  description = "Allow unauthenticated invocations (allUsers)"
  type        = bool
  default     = false
}

# ─── Environment / Labels ────────────────────
variable "environment" {
  description = "Deployment environment injected as ENVIRONMENT env var"
  type        = string
  default     = "dev"
}

variable "extra_env_vars" {
  description = "Additional environment variables for the container"
  type        = map(string)
  default     = {}
}

variable "labels" {
  description = "Labels applied to the Cloud Run service"
  type        = map(string)
  default     = {}
}
