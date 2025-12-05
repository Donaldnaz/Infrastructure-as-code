# Terraform GCP VPC and Compute Environment

This project provisions a small but complete Google Cloud environment using Terraform.  

* Configure the Google provider
* Create a custom VPC network
* Reserve and attach a static IP address
* Launch compute instances
* Create a Cloud Storage bucket for static content
* Use explicit dependencies and a local exec provisioner

## Architecture overview
This Terraform configuration creates the following resources in Google Cloud:

* **VPC network** named `terraform-network`
* **Static external IP address** for one compute instance
* **Primary compute instance**:
  * Machine type `e2 micro`
  * Container Optimized OS image `cos stable`
  * Attached to the custom VPC network
  * Uses the reserved static IP address
  * Writes its public IP to a local file `ip_address.txt` using `local exec`
* **Cloud Storage bucket** named `ikenna_2025`
  * Located in `US`
  * Configured for basic static website hosting with `index.html` and `404.html`
* **Secondary compute instance**:
  * Machine type `e2 micro`
  * Attached to the same VPC network
  * Created only after the storage bucket exists using `depends_on`

## Prerequisites
Before you run this project, you need:

* A Google Cloud project  
* Billing enabled for that project  
* A local environment with:
  * Terraform installed  
  * The Google Cloud CLI installed and authenticated  
* Appropriate permissions to create:
  * VPC networks  
  * Compute instances  
  * Static IP addresses  
  * Storage buckets  

You also need to update the `provider "google"` block with your own:

* `project`
* `region`
* `zone`

Bucket names must be globally unique, so you may also need to change the bucket name from `ikenna_2025` to something that is available.


## Files in this repo

* `main.tf`  
  Contains the full Terraform configuration:
  * Provider configuration
  * Network definition
  * Static IP address
  * Two compute instances
  * Storage bucket with website settings

---

## How to use

### 1. Clone the repository

```bash
git clone <your repo url>
cd <your repo folder>
````

### 2. Update configuration

Open `main.tf` and update:

* `project`, `region`, and `zone` in the `provider "google"` block
* Optionally the names of:

  * The VPC network
  * The instances
  * The bucket (must be globally unique)

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review the execution plan

```bash
terraform plan
```

Check that the resources to be created match your expectations.

### 5. Apply the configuration

```bash
terraform apply
```

Type `yes` when prompted to confirm.

Terraform will:

* Create the VPC network
* Reserve the static IP
* Create the storage bucket
* Launch both compute instances

After the apply completes, look for the file `ip_address.txt` in your local directory. It contains the instance name and public IP address of the primary instance, written by the `local exec` provisioner.


## Cleaning up

To avoid ongoing cloud charges, destroy the environment when you are done:

```bash
terraform destroy
```

Confirm with `yes` when prompted.

This will remove:

* The VPC network
* The static IP address
* Both compute instances
* The storage bucket


## Author

## Anasieze Ikenna -- Cloud Engineer
