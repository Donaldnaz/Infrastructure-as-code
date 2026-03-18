# ─────────────────────────────────────────────
# Enable required GCP APIs
# ─────────────────────────────────────────────
resource "google_project_service" "required_apis" {
  for_each = toset([
    "run.googleapis.com",
    "artifactregistry.googleapis.com",
    "storage.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
  ])

  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}

# ─────────────────────────────────────────────
# Shared labels applied to all resources
# ─────────────────────────────────────────────
locals {
  labels = {
    verse_dev  = var.environment
    team       = var.team
    managed-by = "terraform"
  }
}

# ─────────────────────────────────────────────
# Service Account (created at root so all
# modules can reference it for IAM bindings)
# ─────────────────────────────────────────────
resource "google_service_account" "cloud_run_sa" {
  project      = var.project_id
  account_id   = "${var.service_name}-sa"
  display_name = "Verse Dev ${var.service_name} Service Account"

  depends_on = [google_project_service.required_apis]
}

# ─────────────────────────────────────────────
# Artifact Registry
# ─────────────────────────────────────────────
module "artifact_registry" {
  source = "./modules/artifact_registry"

  project_id         = var.project_id
  region             = var.region
  repository_id      = var.repository_id
  description        = "Docker images for ${var.service_name} (${var.environment})"
  cloud_run_sa_email = google_service_account.cloud_run_sa.email
  labels             = local.labels

  depends_on = [google_project_service.required_apis]
}

# ─────────────────────────────────────────────
# GCS Model Bucket
# ─────────────────────────────────────────────
module "model_bucket" {
  source = "./modules/gcs_bucket"

  project_id         = var.project_id
  bucket_name        = var.model_bucket_name
  location           = var.region
  versioning_enabled = true
  # Allow destroy in non-prod to keep dev/staging clean
  force_destroy      = var.environment != "prod"
  cloud_run_sa_email = google_service_account.cloud_run_sa.email
  labels             = local.labels

  depends_on = [google_project_service.required_apis]
}

# ─────────────────────────────────────────────
# Verse Dev GPU Service
# ─────────────────────────────────────────────
module "verse_dev" {
  source = "./modules/verse_dev"

  project_id    = var.project_id
  region        = var.region
  service_name  = var.service_name
  service_account_email = google_service_account.cloud_run_sa.email

  # Full image URI
  image = "gcr.io/cloudrun/hello"

  # GPU config
  gpu_type  = var.gpu_type
  gpu_count = var.gpu_count
  cpu       = var.cpu
  memory    = var.memory

  # Scaling
  min_instances = var.min_instances
  max_instances = var.max_instances

  # Request handling
  request_timeout     = var.request_timeout
  concurrency         = var.concurrency
  allow_public_access = var.allow_public_access

  extra_env_vars = var.extra_env_vars
  labels         = local.labels

  depends_on = [
    module.artifact_registry,
    google_project_service.required_apis,
  ]
}
