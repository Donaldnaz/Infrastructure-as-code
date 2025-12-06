# General Configurations

name           = "audio-trigger-fn"
env            = "dev"
gcp_project_id = "your-gcp-project-id"
gcp_region     = "us-central1"

# Source & Bucket
bucket_name = "your-audio-upload-bucket"
source_dir  = "../src" # relative to your Terraform module

# Service Accounts (replace with actual IAM emails)
trigger_sa  = "trigger-sa@your-gcp-project-id.iam.gserviceaccount.com"
function_sa = "function-sa@your-gcp-project-id.iam.gserviceaccount.com"

# Runtime environment variables for Cloud Function
env_vars = {
  ENVIRONMENT = "dev"
  LOG_LEVEL   = "debug"
  REGION      = "us-central1"
}

# Configuration
config = {
  runtime       = "python312"
  entry_point   = "translate"
  min_instances = 0
  max_instances = 1
  memory        = "128Mi"
  timeout       = 60
}
