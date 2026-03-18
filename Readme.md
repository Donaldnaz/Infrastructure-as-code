# 🚀 Agentic AI Powered Cloud Infrastructure for ML Inference

## Overview

This project demonstrates how Agentic AI can be used to automate and accelerate cloud infrastructure deployment for machine learning inference.

By combining Terraform with an AI coding agent capable of interacting with my workspace, I reduced deployment time from weeks to hours while maintaining production-level infrastructure quality.

---

## ⚙️ Architecture

- **Cloud Run** → Hosts ML inference service (GPU-enabled)
- **Google Cloud Storage** → Stores trained ML models
- **Artifact Registry** → Stores container images
- **IAM & Service Accounts** → Secure service communication
- **Terraform Modules** → Infrastructure as Code

---

## 🔁 Workflow

1. ML model is stored in GCS bucket  
2. Cloud Run service retrieves model at runtime  
3. Container loads model for inference  
4. API requests hit Cloud Run endpoint  
5. Predictions are returned in real time  

---

## 🤖 Agentic AI Integration

An AI coding agent was used to actively interact with the development environment:

- Read and modified Terraform files (`main.tf`, modules, tfvars)
- Removed deprecated environment variables:
  - `MODEL_BUCKET`
  - `MODEL_PATH`
  - `ENVIRONMENT`
- Implemented GPU configuration (NVIDIA L4)
- Executed Terraform commands:
  - `terraform plan`
  - `terraform apply`
- Debugged deployment errors (e.g., GPU zonal redundancy issue)
- Applied fixes automatically
- Validated deployment results

This created a closed-loop system:

**edit → execute → debug → fix → validate**

---

## ⚡ Key Features

- GPU-enabled Cloud Run (NVIDIA L4)
- Modular Terraform infrastructure
- Secure service-to-service communication
- Dynamic model loading from GCS
- AI-assisted infrastructure automation

---

## Impact

- ⏱ Deployment time reduced from **2–4 weeks → a few hours**
- ⚡ Faster debugging and iteration cycles
- 🔁 Reduced manual DevOps workload
- 👤 Single engineer productivity scaled to team-level output

---

## Tech Stack

- Terraform
- Google Cloud Run (GPU)
- Google Cloud Storage
- Artifact Registry
- Docker
- IAM & Service Accounts
- Agentic AI Coding Assistant

---

## Key Insight

This project showcases a shift from AI-assisted coding to **AI-driven execution**, where the agent performs real engineering tasks within the development environment.

---

## 📌 Future Improvements

- Event-driven model versioning pipeline
- CI/CD integration (GitHub Actions)
