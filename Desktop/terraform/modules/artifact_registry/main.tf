

resource "google_artifact_registry_repository" "this" {


  project       = var.project_id
  location      = var.region
  repository_id = var.repository_id
  format        = "DOCKER"
  description   = var.description
  labels        = var.labels
}

# Allow Cloud Run SA to pull images
# resource "google_artifact_registry_repository_iam_member" "cloud_run_reader" {
# 

#   project    = var.project_id
#   location   = var.region
#   repository = google_artifact_registry_repository.this.name
#   role       = "roles/artifactregistry.reader"
#   member     = "serviceAccount:${var.cloud_run_sa_email}"
# }
