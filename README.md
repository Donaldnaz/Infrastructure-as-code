# **AWS EC2 Instance Deployment using Terraform**

This repository contains Terraform configuration files for deploying an **AWS EC2 instance** with a secure and automated setup.
The goal is to showcase how to use **Infrastructure as Code (IaC)** to provision cloud resources quickly, consistently, and with minimal manual work.

## **The Project Provisions**

* **EC2 Instance:** `t3.micro`
* **Security Group:** with SSH and HTTP access
* **Automatic Tagging:** for easy resource tracking
* **Custom Key Pair:** for secure access

All resources are **created, managed, and destroyed** through Terraform commands.
