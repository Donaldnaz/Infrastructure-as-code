output "repository_id" {
  description = "The repository ID"
  value       = google_artifact_registry_repository.this.repository_id
}

output "registry_url" {
  description = "Full registry URL (e.g. us-central1-docker.pkg.dev/my-project/my-repo)"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.this.repository_id}"
}

output "repository_name" {
  description = "The repository name"
  value       = google_artifact_registry_repository.this.name
}
