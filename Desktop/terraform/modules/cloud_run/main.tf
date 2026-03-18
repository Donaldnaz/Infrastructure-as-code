resource "google_cloud_run_v2_service" "verse_dev" {
  project  = var.project_id
  name     = var.service_name
  location = var.region
  labels   = var.labels

  template {
    service_account = var.service_account_email

    # GPU cold starts can be long — extend the startup deadline
    timeout = var.request_timeout

    max_instance_request_concurrency = var.concurrency

    containers {
      image = var.image

      resources {
        limits = merge(
          {
            cpu    = var.cpu
            memory = var.memory
          },
          var.gpu_count > 0 ? { "nvidia.com/gpu" = tostring(var.gpu_count) } : {}
        )

        # Required for GPU: installs the NVIDIA driver at instance start
        dynamic "gpu_driver_installation_config" {
          for_each = var.gpu_count > 0 ? [1] : []
          content {
            gpu_driver_version = "LATEST"
          }
        }

        startup_cpu_boost = true
      }

      # Model location — your app reads these at startup to pull weights from GCS
      env {
        name  = "MODEL_BUCKET"
        value = var.model_bucket_name
      }

      env {
        name  = "MODEL_PATH"
        value = var.model_path
      }

      env {
        name  = "ENVIRONMENT"
        value = var.environment
      }

      # Any extra env vars passed in from the root module / tfvars
      dynamic "env" {
        for_each = var.extra_env_vars
        content {
          name  = env.key
          value = env.value
        }
      }

      # Startup probe — wait for model to load before sending traffic
      startup_probe {
        http_get {
          path = var.health_check_path
        }
        initial_delay_seconds = var.startup_probe_initial_delay
        timeout_seconds       = 10
        period_seconds        = 15
        failure_threshold     = 20  # allow up to 5min for model load
      }

      # Liveness probe — restart container if it becomes unresponsive
      liveness_probe {
        http_get {
          path = var.health_check_path
        }
        period_seconds    = 30
        timeout_seconds   = 10
        failure_threshold = 3
      }
    }

    scaling {
      min_instance_count = var.min_instances
      max_instance_count = var.max_instances
    }

    # Pin to GPU node pool
    dynamic "node_selector" {
      for_each = var.gpu_count > 0 ? [1] : []
      content {
        accelerator = var.gpu_type
      }
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}

# Optional: allow unauthenticated (public) invocations
resource "google_cloud_run_v2_service_iam_member" "public_invoker" {
  count    = var.allow_public_access ? 1 : 0
  project  = var.project_id
  location = var.region
  name     = google_cloud_run_v2_service.verse_dev.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
