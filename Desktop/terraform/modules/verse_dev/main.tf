resource "google_cloud_run_v2_service" "verse_dev" {
  project  = var.project_id
  name     = var.service_name
  location = var.region
  labels   = var.labels

  template {
    service_account = var.service_account_email

    annotations = var.gpu_count > 0 ? {
      "run.googleapis.com/gpu-type" = var.gpu_type
      "run.googleapis.com/zonal-redundancy" = "disabled"
    } : {}

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

          startup_cpu_boost = true
      }

      # Any extra env vars passed in from the root module / tfvars
      dynamic "env" {
        for_each = var.extra_env_vars
        content {
          name  = env.key
          value = env.value
        }
      }

      ports {
        container_port = 8080
      }

      # Startup probe — wait for model to load before sending traffic
      startup_probe {
        tcp_socket {
          port = 8080
        }
        initial_delay_seconds = 0
        timeout_seconds       = 240
        period_seconds        = 240
        failure_threshold     = 1
      }
    }

    scaling {
      min_instance_count = var.min_instances
      max_instance_count = var.max_instances
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
