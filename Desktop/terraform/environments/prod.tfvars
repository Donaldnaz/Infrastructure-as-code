# ─────────────────────────────────────────────
# environments/prod.tfvars
# ─────────────────────────────────────────────
project_id  = "my-project-prod"
region      = "us-central1"
environment = "prod"
team        = "ml-platform"

# Artifact Registry
repository_id = "inference-images-prod"

# GCS Model Bucket
model_bucket_name = "verse-prod-models"
model_path        = "llama3/model.bin"

# Cloud Run
service_name  = "inference-api"
image_name    = "inference-api"
image_tag     = "v1.0.0"  # Pin to a specific tag in prod, never use "latest"

gpu_type  = "nvidia-l4"
gpu_count = 1
cpu       = "8"
memory    = "32Gi"

# Keep at least one instance warm — GPU cold starts are 30-90s
min_instances = 1
max_instances = 10

request_timeout     = "300s"
concurrency         = 1
allow_public_access = false

extra_env_vars = {
  LOG_LEVEL     = "WARNING"
  MODEL_BACKEND = "transformers"
}
