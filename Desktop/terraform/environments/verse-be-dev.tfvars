# ─────────────────────────────────────────────
# environments/verse-be-dev.tfvars
# ─────────────────────────────────────────────
project_id  = "verse-dev-433901"
region      = "us-central1"
environment = "verse-dev"
team        = "mariner-team"

# Artifact Registry
repository_id = "transcription-images"

# GCS Model Bucket
model_bucket_name = "cosmos-transcription-diarization-models-v3"

# Cloud Run
service_name  = "verse-be-dev"
image_name    = "whisperx"
gpu_count = 0
cpu       = "4"
memory    = "16Gi"

min_instances = 1
max_instances = 1

request_timeout     = "3600s"
concurrency         = 1
allow_public_access = false

extra_env_vars = {
  MODEL_STORAGE_BUCKET   = "cosmos-transcription-diarization-models-v3"
  WHISPERX_MODEL_PREFIX  = "whisperx"
  WHISPERX_ALIGN_PREFIX  = "whisperx/alignment"
}