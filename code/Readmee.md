# Deploy a Static HTML Website on AWS EC2 Using Terraform

This project provisions an **Amazon EC2 instance** using **Terraform**, installs the **Apache HTTP Server**, and deploys a **static HTML website** by executing a `web.sh` script on the remote host. The HTML content is zipped and pushed to the server, extracted, and served via Apache.

## Project Overview

### What It Does

- Provisions an EC2 instance in your chosen AWS region
- Creates a security group allowing inbound SSH (port 22) and HTTP (port 80) traffic
- Installs Apache web server via a remote shell script
- Uploads a zipped HTML template
- Extracts the HTML archive into the Apache web root
- Outputs the public IP to access the site

## Project Structure

```
├── ec2_inst.tf        # Terraform configuration for AWS resources
├── vars.tf            # Input variable definitions
├── backend.tf         # Centra repo to store state file
├── keypair.tf         # Outputs such as EC2 public IP
├── secgrp.tf          # Neworking Configurations
├── web.sh             # Shell script to install Apache and deploy HTML
├── provider.tf        # Cloud Platform
└── Readme.md          # Project documentation

````

## Prerequisites

Ensure the following tools and settings are in place:

| Requirement     | Description                                                                |
|----------------|-----------------------------------------------------------------------------|
| Terraform CLI   | [Install Terraform](https://developer.hashicorp.com/terraform/install)     |
| AWS CLI         | [Install AWS CLI](https://aws.amazon.com/cli/) & run `aws configure`       |
| AWS Account     | IAM user with sufficient EC2 and VPC permissions                           |
| SSH Key Pair    | Used to SSH into the instance and for Terraform remote access              |
| HTML Website    | A valid `html` file with `index.html` at the root                          |

---

## How to Deploy

### 1. Clone the Repository

```bash
git clone https://github.com/donaldnaz/terraform-ec2-html-deploy.git
cd terraform-ec2-html-deploy
````

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Format & Validate Terraform

```bash
terraform fmt
```

```bash
terraform validate
```

### 4. Plan the Deployment

```bash
terraform plan
```

### 5. Apply the Deployment

```bash
terraform apply
```

Type `yes` when prompted to confirm the creation of resources.

---

## Accessing the Website

Once the deployment is complete, Terraform will output the EC2 instance's **public IP address**.

Open your browser and visit:

```
http://<EC2_PUBLIC_IP>
```

## Script Details – `web.sh`

The `web.sh` script:

1. Installs Apache (`httpd`)
2. Installs `unzip` if not present
3. Uploads and extracts `html.zip` into `/var/www/html`
4. Starts and enables the Apache service

## Clean Up Resources

To destroy the infrastructure and avoid AWS charges:

```bash
terraform destroy
```

## Author

**Anasieze Ikenna – Cloud Engineer**


