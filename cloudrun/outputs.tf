output "name" {
  value = google_cloudfunctions2_function.default.name
}

output "entry_point" {
  value = var.config.entry_point
}
