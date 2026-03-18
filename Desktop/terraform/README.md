# Terraform — Cloud Run GPU Inference Stack

Deploys a modular, repeatable GCP inference stack:

- **Cloud Run v2** — GPU-enabled inference service  
- **Artifact Registry** — Docker image storage  
- **GCS Bucket** — Model artifact storage  
- **Service Account + IAM** — Least-privilege access wiring

---

## Structure

```
terraform/
├── providers.tf              # Terraform & Google provider config
├── main.tf                   # Root: enables APIs, creates SA, calls modules
├── variables.tf              # All root-level input variables
├── outputs.tf                # Service URL, registry URL, helper commands
├── environments/
│   ├── dev.tfvars
│   ├── staging.tfvars
│   └── prod.tfvars
└── modules/
    ├── artifact_registry/    # Docker image repo + IAM
    ├── gcs_bucket/           # Model storage bucket + IAM
    └── cloud_run/            # Cloud Run v2 GPU service
```

---

## Prerequisites

1. [Terraform >= 1.5.0](https://developer.hashicorp.com/terraform/install)
2. [gcloud CLI](https://cloud.google.com/sdk/docs/install) authenticated:
   ```bash
   gcloud auth application-default login
   ```
3. GPU quota approved in your GCP project for your chosen region.
4. Billing enabled on the project.

---

## Usage

### First-time setup

```bash
cd terraform
terraform init
```

### Deploy to an environment

```bash
# Dev
terraform plan  -var-file="environments/dev.tfvars"
terraform apply -var-file="environments/dev.tfvars"

# Staging
terraform plan  -var-file="environments/staging.tfvars"
terraform apply -var-file="environments/staging.tfvars"

# Prod
terraform plan  -var-file="environments/prod.tfvars"
terraform apply -var-file="environments/prod.tfvars"
```

### Tear down

```bash
terraform destroy -var-file="environments/dev.tfvars"
```

> ⚠️ The prod model bucket has `force_destroy = false`. You must empty it manually before destroying prod infrastructure.

---

## Push a Docker Image

After applying, Terraform outputs the exact commands:

```bash
terraform output docker_push_example
```

Or manually:

```bash
gcloud auth configure-docker <region>-docker.pkg.dev

docker build -t <region>-docker.pkg.dev/<project>/<repo>/<image>:<tag> .
docker push     <region>-docker.pkg.dev/<project>/<repo>/<image>:<tag>
```

---

## Upload a Model to GCS

```bash
gsutil -m cp -r ./path/to/model/ gs://<model_bucket_name>/llama3/
```

Your Cloud Run container receives `MODEL_BUCKET` and `MODEL_PATH` as environment variables at startup.

---

## Supported GPU Types

| Value | GPU | Use case |
|---|---|---|
| `nvidia-l4` | L4 24GB | Default — cost-efficient inference |
| `nvidia-a100-80gb` | A100 80GB | Large models (70B+) |
| `nvidia-tesla-t4` | T4 16GB | Budget / small models |

---

## Key Design Decisions

| Decision | Reason |
|---|---|
| SA created at root, passed into modules | Avoids circular dependencies on IAM bindings |
| `force_destroy = env != prod` | Protects prod model bucket from accidental deletion |
| `min_instances = 1` in prod | GPU cold starts are 30–90s; keep one instance warm |
| `image_tag = "latest"` only in dev | Pin explicit tags in staging/prod for reproducibility |
| `concurrency = 1` | GPU memory is not safely shared across concurrent requests |
| `startup_probe failure_threshold = 20` | Allows up to ~5 min for large model weights to load from GCS |

---

## Remote State (Recommended for Teams)

Uncomment the `backend "gcs"` block in `providers.tf` and create the state bucket first:

```bash
gsutil mb gs://my-project-tfstate
gsutil versioning set on gs://my-project-tfstate
```

Then re-init:

```bash
terraform init -reconfigure
```
