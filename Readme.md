# HTTPS Content Based Load Balancer with Terraform (GCP)

This repository contains Terraform configuration that builds a global HTTPS content based load balancer on Google Cloud Platform.  

The setup shows how to route traffic through a global HTTPS load balancer to a custom URL map that sends users to the nearest region, serving static content from Cloud Storage buckets.

## Project Overview

Using Terraform, this project:

* Configures the Google provider and remote resources in a dedicated GCP project  
* Creates a global HTTPS content based load balancer  
* Uses URL maps to route traffic to different backends based on host or path rules  
* Serves static web content from Cloud Storage buckets behind the load balancer
* Manages TLS keys and certificates through Terraform so the website is exposed securely over HTTPS

## Architecture

At a high level, the Terraform code provisions:

<img width="1511" height="739" alt="image" src="https://github.com/user-attachments/assets/131cbbb8-dd83-43de-8cb5-2a080f0cad9a" />


* A global external HTTPS load balancer  
* A URL map that defines routing rules  
* Backend buckets that point to one or more Cloud Storage buckets  
* A target HTTPS proxy and forwarding rule to expose the site on port 443  
* SSL or TLS certificate resources to terminate HTTPS at the load balancer  

Traffic flow:

1. User visits the load balancer external IP or configured domain name  
2. The HTTPS load balancer terminates TLS  
3. The URL map selects a backend based on host or path rules  
4. Static content is returned from the Cloud Storage bucket closest to the user  

---

## Repository Structure

Adapt this section to match your files if they are named differently:

```text
.
├── main.tf              # Core Terraform configuration and resources
├── variables.tf         # Input variables such as project and region
├── outputs.tf           # Useful outputs such as load balancer IP or URL
├── versions.tf          # Terraform and provider version constraints
├── terraform.tfvars     # Local values for your environment (git ignored)
└── README.md            # Project documentation
