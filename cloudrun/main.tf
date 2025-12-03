# Data source for existing bucket
data "google_storage_bucket" "function_bucket" {
  name = var.bucket_name
}

# Archive source code
data "archive_file" "source_code" {
  type        = "zip"
  output_path = "${var.source_dir}/${var.env}-${var.name}.zip"
  source_dir  = var.source_dir
}

# Upload source code to bucket
resource "google_storage_bucket_object" "source_code" {
  name   = "${var.env}-${varI.name}.zip"
  bucket = data.google_storage_bucket.function_bucket.name
  source = data.archive_file.source_code.output_path

  lifecycle {
    create_before_destroy = true
  }
}

# Cloud Function v2
resource "google_cloudfunctions2_function" "default" {
  name        = var.name
  location    = var.gcp_region
  project     = var.gcp_project_id
  description = "Trigger function for - ${var.env}-${var.name}"

  build_config {
    runtime               = var.config.runtime
    entry_point           = var.config.entry_point
    environment_variables = var.env_vars
    source {
      storage_source {
        bucket = data.google_storage_bucket.function_bucket.name
        object = google_storage_bucket_object.source_code.name
      }
    }
  }

  service_config {
    max_instance_count             = var.config.max_instances
    min_instance_count             = var.config.min_instances
    available_memory               = var.config.memory
    timeout_seconds                = var.config.timeout
    environment_variables          = var.env_vars
    ingress_settings               = "ALLOW_INTERNAL_ONLY"
    all_traffic_on_latest_revision = true
    service_account_email          = var.function_sa
  }

  event_trigger {
    trigger_region        = var.gcp_region
    event_type            = "google.cloud.storage.object.v1.finalized"
    retry_policy          = "RETRY_POLICY_RETRY"
    service_account_email = var.trigger_sa
    event_filters {
      attribute = "bucket"
      value     = data.google_storage_bucket.function_bucket.name
    }
  }

  lifecycle {
    replace_triggered_by = [
      google_storage_bucket_object.source_code
    ]
  }

    depends_on = [
      google_storage_bucket_object.source_code
  ]
}