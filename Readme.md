# HTTPS Content Based Load Balancer with Terraform

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


## Repository Structure

```text
.
├── script.sh.tpl     # Template for the VM startup script
├── gcp-logo.svg      # Google Cloud logo used in app UI
├── main.tf           # Core Terraform configuration and resource definitions
├── mig.tf            # Managed instance group and related backend resources
├── outputs.tf        # Terraform output values such as external IP or URLs
├── README.md         # Project documentation (this file)
├── versions          # Provider versions
├── tls.tf            # TLS provider resources and HTTPS certificate setup
└── variables.tf      # Input variables

```

## Usage

1. **Initialize Terraform**

   ```bash
   terraform init
   ```
   
2. **Review the execution plan**

   ```bash
   terraform plan -out=tfplan
   ```
   
<img width="1344" height="356" alt="Screenshot 2025-12-07 at 1 21 11 PM" src="https://github.com/user-attachments/assets/3672aaa2-b9a2-49ae-ae00-52cc88eebf2a" />

3. **Apply the configuration**

   ```bash
   terraform apply tfplan
   ```
<img width="1440" height="729" alt="Screenshot 2025-12-07 at 1 22 24 PM" src="https://github.com/user-attachments/assets/38915d2d-d69d-427b-a27a-691d5e513ffd" />

4. **Verify the deployment**

   After apply completes, check the outputs:

   ```bash
   terraform output
   ```

   ```bash
   echo "https://$(terraform output -raw lb_ip)"
   ```
   
<img width="1440" height="641" alt="Screenshot 2025-12-07 at 1 30 50 PM" src="https://github.com/user-attachments/assets/542c8ebe-702a-48d5-91dd-61ade4969f62" />

---

## Clean up

To avoid ongoing charges in your Google Cloud project destroy the resources when you are done:

```bash
terraform destroy
```

## Anasieze Ikenna - Cloud Engineer

