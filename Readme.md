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

This is a great example of how to manage cloud infrastructure and Kubernetes resources in one place.

---

## Objectives

In this branch & repository, I:

- Deploy a GKE cluster using Terraform  
- Configure the Terraform Kubernetes provider to talk to that cluster  
- Deploy an NGINX based application to the cluster  
- Expose the application externally through a Service of type LoadBalancer  
- Validate that traffic is being routed correctly to the pods

---

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

---

## Repository Structure

```text
.
├── main.tf          # GCP resources such as the GKE cluster
├── k8s.tf           # Kubernetes resources such as Deployment and Service
├── versions.tf      # Terraform and provider version constraints
├── terraform.tfvars # Variable values for project, region, cluster settings
└── README.md        # This file

```


## Author
# Anasieze Ikenna - Cloud Engineer
