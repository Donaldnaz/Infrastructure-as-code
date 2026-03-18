# ─────────────────────────────────────────────
# environments/dev.tfvars
# ─────────────────────────────────────────────
project_id  = "verse-dev-433901"
region      = "us-central1"
environment = "verse-dev"
team        = "ml-platform"

# Artifact Registry
repository_id = "inference-images-dev"

# GCS Model Bucket
model_bucket_name = "verse-dev-models"

# Cloud Run
service_name  = "inference-api-dev"
image_name    = "inference-api"
image_tag     = "latest"

gpu_type  = "nvidia-l4"
gpu_count = 0
cpu       = "8"
memory    = "32Gi"

# Scale to zero in dev to save cost
min_instances = 0
max_instances = 2

request_timeout     = "300s"
concurrency         = 1
allow_public_access = false

extra_env_vars = {
  LOG_LEVEL     = "DEBUG"
  MODEL_BACKEND = "transformers"
}
