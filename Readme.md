# IAM Roles and Bindings for Terraform Deployments

This Terraform module manages **custom IAM roles** and **role bindings** required for deploying GCP infrastructure. It grants appropriate permissions to service accounts for use with Cloud Run, Cloud Functions, GKE, VPC, Vertex AI, and other key GCP services.

## Resources Created
- Custom IAM Role: `Terraform Deployer`
- Project-level IAM bindings:
- Terraform Service Account
- Cloud Run Service Account
- Cloud Functions Service Account
- GCS + Eventarc + Artifact Registry permissions
- Optional: GKE Service Account (commented out)
