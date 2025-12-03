variable "name" {
  description = "The name of the Cloudrun"
  type        = string
}

variable "gcp_region" {
  description = "The GCP region for the Cloudrun"
  type        = string
}

variable "gcp_project_id" {
  description = "The Google Project Id"
  type        = string
}

variable "env" {
  description = "Environment variable"
  type        = string
}

variable "source_dir" {
  description = "The source code directory for Cloudrun"
  type        = string
}

variable "trigger_sa" {
  description = "The Trigger service account email"
  type        = string
}

variable "function_sa" {
  description = "The Cloud Run Function service account email"
  type        = string
}

variable "env_vars" {
  description = "Cloud Run Functions environment variables"
  type        = map(string)
}

variable "config" {
  type = object({
    runtime       = string
    entry_point   = string
    min_instances = number
    max_instances = number
    memory        = string
    timeout       = number
  })
  default = (
    {
      runtime       = "python312"
      entry_point   = "translate_on_upload"
      min_instances = 0
      max_instances = 1
      memory        = "128Mi"
      timeout       = 60
    }
  )
  description = "Cloud Run Function Service settings"
}

#optional
variable "build_vars" {
  description = "Cloud Run Functions build environment variables"
  type        = map(string)
  default     = null
}

variable "bucket_name" {
  description = "The input bucket of audio preprocessing"
  type        = string
}