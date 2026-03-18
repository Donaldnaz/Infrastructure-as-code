output "service_url" {
  description = "The URL of the deployed Cloud Run service"
  value       = google_cloud_run_v2_service.verse_dev.uri
}

output "service_name" {
  description = "The name of the Cloud Run service"
  value       = google_cloud_run_v2_service.verse_dev.name
}

output "latest_revision" {
  description = "The latest revision name"
  value       = google_cloud_run_v2_service.verse_dev.latest_ready_revision
}
