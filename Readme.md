# Deploy Kubernetes Load Balancer Service with Terraform

The project uses **Terraform** to provision a **Google Kubernetes Engine (GKE) cluster** and deploy an **NGINX application** exposed through a **Kubernetes Service of type LoadBalancer**, all on **Google Cloud Platform (GCP)**.

## Project Overview

The goal of this project is to show how **Infrastructure as Code** can manage both:

1. The Kubernetes infrastructure itself  
2. The application and its load balanced entry point

Instead of creating the cluster with the console and deploying workloads with `kubectl` alone, Terraform is used as a single control plane for:

- GKE cluster creation  
- Kubernetes provider configuration  
- NGINX deployment  
- Load balancer service exposure  

## Objectives

In this branch & repository, I:

- Deploy a GKE cluster using Terraform  
- Configure the Terraform Kubernetes provider to talk to that cluster  
- Deploy an NGINX based application to the cluster  
- Expose the application externally through a Service of type LoadBalancer  
- Validate that traffic is being routed correctly to the pods


## Architecture

At a high level the architecture looks like this:

- **Google Cloud Platform**
  - GKE cluster in a single region and zone
  - Node pool running the Kubernetes workloads

- **Kubernetes**
  - NGINX Deployment (set of pods)
  - Service of type LoadBalancer that:
    - Gets an external IP from GCP
    - Forwards user traffic to NGINX pods

- **Terraform**
  - Google provider to create the GKE cluster and required IAM or networking
  - Kubernetes provider to create the Deployment and Service inside the cluster


## Repository Structure

```text
.
├── main.tf          # GCP resources such as the GKE cluster
├── k8s.tf           # Kubernetes resources such as Deployment and Service
├── output.tf        # Infrastructure Output details
├── versions.tf      # Terraform and provider version constraints
├── vars.tf          # Variable values for project, region, cluster settings
└── README.md        # This file

```

## Prerequisites

To run this project you will need:

* A Google Cloud project with billing enabled
* `gcloud` CLI installed and authenticated
* `terraform` CLI installed
* Basic familiarity with:

  * Kubernetes concepts: pods, deployments, services
  * Terraform commands: `init`, `plan`, `apply`

## Setup

<img width="1440" height="634" alt="Screenshot 2025-12-06 at 1 32 30 PM" src="https://github.com/user-attachments/assets/ee3ae509-9398-4864-961a-167c40f14ee9" />

1. **Clone the repository**

   ```bash
   git clone https://github.com/<your-username>/<your-repo-name>.git
   cd <your-repo-name>
   ```

2. **Set your Google Cloud project and region**

   Update `vars.tf` section in your `*.tf` files with values such as:

   ```hcl
   project_id = "your-gcp-project-id"
   region     = "us-central1"
   zone       = "us-central1-a"
   ```
   
## Deploying the Infrastructure

1. **Initialize Terraform**

   ```bash
   terraform init
   ```

2. **Review the execution plan**

   ```bash
   terraform plan
   ```

3. **Apply the configuration**

   ```bash
   terraform apply
   ```

## Verifying the Deployment

1. **Get Kubernetes credentials for `kubectl`**

   ```bash
   gcloud container clusters get-credentials <cluster-name> --zone <cluster-zone> --project <project-id>
   ```

<img width="1440" height="725" alt="Screenshot 2025-12-06 at 1 02 18 PM" src="https://github.com/user-attachments/assets/b30d4ddf-ff0f-4371-9d6e-3b9cff94c81b" />


3. **Check pods and services**

   ```bash
   kubectl get pods
   kubectl get svc
   ```

   Note the **external IP** assigned to the Service of type LoadBalancer.
   
<img width="1440" height="476" alt="Screenshot 2025-12-06 at 1 05 15 PM" src="https://github.com/user-attachments/assets/de9de856-d30c-426a-9e40-194617acdcef" />


4. **Test the NGINX endpoint**

   ```bash
   curl http://<external-ip>
   ```
   
<img width="1440" height="433" alt="Screenshot 2025-12-06 at 1 06 37 PM" src="https://github.com/user-attachments/assets/dbaf4147-100d-420d-a171-57cc6c1b2f8b" />


## Anasieze Ikenna - Cloud Engineer
