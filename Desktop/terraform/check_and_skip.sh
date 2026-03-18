#!/bin/bash

# Script to conditionally include Terraform modules based on existing resources
# If bucket exists, comment out the gcs_bucket module
# If artifact registry repo exists, comment out the artifact_registry module
# Check GPU region support and fallback to another USA region if needed

set -e

PROJECT_ID="$1"
REGION="$2"
BUCKET_NAME="$3"
REPO_ID="$4"
TFVARS_FILE="$5"
MAIN_TF="/Users/apple/Desktop/terraform/main.tf"

if [ -z "$PROJECT_ID" ] || [ -z "$REGION" ] || [ -z "$BUCKET_NAME" ] || [ -z "$REPO_ID" ] || [ -z "$TFVARS_FILE" ]; then
  echo "Usage: $0 <project_id> <region> <bucket_name> <repo_id> <tfvars_file>"
  exit 1
fi

# Supported GPU regions for Cloud Run
GPU_REGIONS=("us-central1" "us-east1" "us-west1" "us-south1" "europe-west1" "asia-southeast1")

# Check if region supports GPU
REGION_SUPPORTED=false
for supported_region in "${GPU_REGIONS[@]}"; do
  if [ "$REGION" = "$supported_region" ]; then
    REGION_SUPPORTED=true
    break
  fi
done

if [ "$REGION_SUPPORTED" = false ]; then
  echo "Region $REGION does not support Cloud Run GPUs, switching to us-central1"
  REGION="us-central1"
  # Update region in tfvars file
  sed -i '' "s/region      = \".*\"/region      = \"$REGION\"/" "$TFVARS_FILE"
fi

echo "Using region: $REGION"
echo "Checking for existing resources..."

# Check if bucket exists (buckets are global)
if gcloud storage buckets describe "gs://$BUCKET_NAME" --project="$PROJECT_ID" >/dev/null 2>&1; then
  echo "Bucket $BUCKET_NAME exists, commenting out gcs_bucket module"
  sed -i '' '/^module "model_bucket" {/,/^}/ { /^#/! s/^/#/ }' "$MAIN_TF"
else
  echo "Bucket $BUCKET_NAME does not exist, will create"
fi

# Check if artifact registry repo exists in the region
if gcloud artifacts repositories describe "$REPO_ID" --location="$REGION" --project="$PROJECT_ID" >/dev/null 2>&1; then
  echo "Repository $REPO_ID exists in $REGION, commenting out artifact_registry module"
  sed -i '' '/^module "artifact_registry" {/,/^}/ { /^#/! s/^/#/ }' "$MAIN_TF"
else
  echo "Repository $REPO_ID does not exist in $REGION, will create"
  # Remove the data source and count from the module to avoid plan issues
  sed -i '' '/^data "google_artifact_registry_repository" "existing" {/,/^}/ d' "$MAIN_TF"
  sed -i '' '/^locals {/,/^}/ d' "$MAIN_TF"
  sed -i '' 's/count = local\.repo_exists ? 0 : 1//' "$MAIN_TF"
  sed -i '' 's/count = local\.repo_exists ? 0 : 1//' "$MAIN_TF"  # for the IAM if any
fi

echo "Ready to run Terraform. Existing resources will be skipped."