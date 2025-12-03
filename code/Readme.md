## `README.md`: Deploy HTML Website to EC2 with Terraform
# Deploy Static HTML Website to AWS EC2 with Terraform
This project uses **Terraform** to provision an EC2 instance on **AWS**, install **Apache**, and deploy a static HTML.

## What It Does
Provisions an EC2 instance in your selected region  
Installs Apache automatically via user data  
Downloads and extracts an HTML template  
Serves the website via public IP

## Folder Structure

├── main.tf               # EC2 instance & provisioning logic
├── variables.tf          # Input variables (region, AMI, etc.)
├── outputs.tf            # Public IP output
├── security.tf           # Security group config
├── web.sh                # Script to execute HTML
├── README.md             # You are here


## Requirements
- [Terraform CLI](https://developer.hashicorp.com/terraform/install)
- AWS account
- IAM credentials (with EC2 permissions)

## How to Deploy
1. **Clone this repo**
2. **Initialize Terraform**
3. **Plan the deployment**
4. **Apply and deploy**
5. **Output**
6. **Visit your website**
