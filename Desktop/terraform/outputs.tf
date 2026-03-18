output "verse_dev_url" {
  description = "URL of the deployed Verse Dev inference service"
  value       = module.verse_dev.service_url
}

output "artifact_registry_url" {
  description = "Full Artifact Registry URL to use in docker push commands"
  value       = module.artifact_registry.registry_url
}

# output "model_bucket_name" {
#   description = "GCS bucket name for model artifacts"
#   value       = module.model_bucket.bucket_name
# }

# output "model_bucket_url" {
#   description = "GCS bucket URL (gs://...)"
#   value       = module.model_bucket.bucket_url
# }

output "cloud_run_sa_email" {
  description = "Service account email used by Verse Dev"
  value       = google_service_account.cloud_run_sa.email
}

output "docker_push_example" {
  description = "Example docker build & push commands"
  value       = <<-EOT
    # Authenticate Docker to Artifact Registry:
    gcloud auth configure-docker ${var.region}-docker.pkg.dev

    # Build and push:
    docker build -t ${module.artifact_registry.registry_url}/${var.image_name}:${var.image_tag} .
    docker push ${module.artifact_registry.registry_url}/${var.image_name}:${var.image_tag}
  EOT
}
