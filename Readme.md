# AWS EC2 Instance Deployment using Terraform

This repository provides a simple and secure example of using **Terraform** to deploy an **Amazon EC2 instance** in AWS. It demonstrates the power of **Infrastructure as Code (IaC)** for provisioning infrastructure in a consistent, automated, and repeatable manner.

## Resources Provisioned

This Terraform project provisions the following AWS resources:

| Resource Type         | Description                                                                |
|----------------------|-----------------------------------------------------------------------------|
| **EC2 Instance**      | A lightweight `t3.micro` Amazon Linux 2 instance.                          |
| **Security Group**    | Allows inbound traffic on ports **22 (SSH)** and **80 (HTTP)**.            |
| **Key Pair**          | Custom key pair generated for secure SSH access to the instance.           |
| **Tags**              | Automatic tagging for environment and resource identification.             |


## Prerequisites

Before you begin, ensure the following tools are installed:

- [Terraform](https://developer.hashicorp.com/terraform/downloads) (v1.3+)
- [AWS CLI](https://aws.amazon.com/cli/)
- AWS credentials configured in your environment (e.g. via `aws configure`)

---

## Implementation Step

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/aws-ec2-terraform.git
cd aws-ec2-terraform
````

### 2. Format Terraform

```bash
terraform fmt
```
### 3. Validate Terraform

```bash
terraform validate
```

### 4. Initialize Terraform

```bash
terraform init
```

### 5. Review the Execution Plan

```bash
terraform plan
```

### 6. Apply the Configuration

```bash
terraform apply
```


**Anasieze Ikenna – Cloud Engineer**
