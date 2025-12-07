# Cloud SQL with Terraform

This repository contains Terraform configuration to provision **Cloud SQL**

## Overview

The project demonstrates how to:

* Define Cloud SQL infrastructure using Terraform
* Provision Cloud SQL instances for MySQL
* Install and run the Cloud SQL Auth Proxy from Cloud Shell
* Connect to the database securely using standard command line clients
* Manage database users and simple test schemas


## Objectives

* Create a Cloud SQL instance with Terraform
* Install the Cloud SQL Auth Proxy in Cloud Shell
* Test connectivity with a MySQL client
  

## Architecture

At a high level, the configuration provisions:

<img width="695" height="371" alt="Screenshot 2025-12-07 at 6 47 57 PM" src="https://github.com/user-attachments/assets/7446ccdc-6577-40e5-8bf5-7d2ad8599f9a" />


* Cloud SQL instance
* A **database** inside each instance for application data
* A **database user** with a password stored in Terraform variables
* **network settings** such as private IP or authorized networks
* Outputs that expose:
  * Instance connection name
  * Public IP address when enabled
  * Default database and user names

Connectivity pattern:

1. Terraform creates the Cloud SQL instance and database.
2. You start the Cloud SQL Auth Proxy in Cloud Shell, using the instance connection name.
3. The proxy opens a local TCP port.
4. The MySQL client connects to that local port, and the proxy securely forwards traffic to Cloud SQL.


## Repository Structure

```text
.
├── main.tf         # Provider config and core Cloud SQL resources
├── variables.tf    # Input variables such as project, region, db version
├── outputs.tf      # Connection name, instance IP, and other outputs
└── README.md       # Project documentation
````

## Prerequisites

You will need:

* A Google Cloud project with billing enabled
* Permission to create Cloud SQL instances and related IAM roles
* Terraform installed locally or use Cloud Shell where Terraform is already available
* Google Cloud SDK if working from your own machine
* Basic familiarity with SQL and the MySQL client


## Deploy with Terraform

1. **Initialize Terraform**

   ```bash
   terraform init
   ```

2. **Review the plan**

   ```bash
   terraform plan
   ```

3. **Apply the configuration**

   ```bash
   terraform apply
   ```

   Terraform will:

   * Create the Cloud SQL instance
   * Create the database and user
   * Output connection details

4. **Inspect outputs**

   ```bash
   terraform output
   ```

## Connect with Cloud SQL Auth Proxy

1. **Download or use the preinstalled proxy**

   In Cloud Shell, you can often use:

   ```bash
   wget https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.11.4/cloud-sql-proxy.linux.amd64 -O cloud-sql-proxy
   chmod +x cloud-sql-proxy
   ```

2. **Start the proxy**

   Replace the connection name with your output:

   ```bash
   ./cloud-sql-proxy $INSTANCE_CONNECTION_NAME \
     --port=3306
   ```

3. **Connect with MySQL client**

   ```bash
   mysql -h 127.0.0.1 -P 3306 -udefault -p
   ```

   Enter the password you set in Terraform. Once connected, you can run simple SQL commands:

   ```sql
   SHOW DATABASES;
   ```

## Author
# Anasieze Ikenna - Cloud Engineer
