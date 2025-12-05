# IAM Roles for GCP Deployments using Terraform

This Terraform module manages **custom IAM roles** and **IAM bindings** to enable secure and controlled deployments of infrastructure across Google Cloud Platform (GCP). It grants appropriate permissions to service accounts used by **Terraform**, **Cloud Run**, **Cloud Functions**, **GCS**, **Eventarc**, **Artifact Registry**, and optionally **GKE** and **Vertex AI**.


## Resources Created

This module provisions the following:

- **Custom IAM Role**: `Terraform Deployer` with least-privilege permissions
- **Project-level IAM Bindings**:
  - Terraform Service Account
  - Cloud Run Service Account
  - Cloud Functions Service Account
  - Artifact Registry + GCS + Eventarc Permissions
  - *(Optional)* GKE Service Account (commented or conditionally enabled)

## Use Cases

- Secure and scalable IAM setup for Terraform infrastructure deployments
- Enable permissions for CI/CD pipelines (Cloud Build, GitHub Actions)
- Deploy workloads across GCP services with tightly scoped IAM roles
- Automate IAM policies as part of infrastructure provisioning

## Requirements

Ensure the following are configured:

| Tool | Version |
|------|---------|
| Terraform CLI | >= 1.3 |
| Google Provider | >= 5.0 |
| GCP Project | IAM Admin rights required |


## Module Structure

```

.
├── main.tf            # IAM roles and bindings
├── variables.tf       # Input variable definitions
├── outputs.tf         # Outputs (service account emails, role ID)
└── README.md          # Project documentation

````

## Security Best Practices

* Follows **Principle of Least Privilege** with custom roles instead of `roles/editor`
* IAM bindings are **scoped at the project level** only
* Separate **Terraform SA** and **workload SAs** for better isolation
* Ideal for use in automated CI/CD pipelines and secure GCP foundations


## Cleanup

To delete all IAM bindings, custom roles, and service accounts:

```bash
terraform destroy
```


## Author

**Anasieze Ikenna – Cloud Engineer**
