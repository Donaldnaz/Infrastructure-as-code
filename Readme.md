# Robot Research Infrastructure Automation with AWS CloudFormation

>  Infrastructure-as-Code (IaC) project to automate a standardized AWS environment for robotics research deployments using AWS CloudFormation.

## Project Description

This project simulates a real-world scenario where a robotics research team, seeks to standardize and automate their cloud infrastructure to minimize human error and accelerate deployment workflows.

Using **AWS CloudFormation**, I designed and deployed a repeatable infrastructure stack that provisions the necessary AWS services — including **Amazon EC2** and **Amazon S3** — fully automated through YAML templates.

The project emphasizes best practices in Infrastructure-as-Code (IaC), making environments easily reproducible, version-controlled, and scalable across different stages (Dev, Test, Prod).

## Key Objectives

- Automate AWS infrastructure using CloudFormation
- Define reusable infrastructure using YAML
- Minimize manual provisioning and human error
- Implement real-world robotics deployment use case

## AWS Services Used

- **AWS CloudFormation** – for defining and provisioning infrastructure as code  
- **Amazon EC2** – to run robotics research workloads  
- **Amazon S3** – for storing input/output artifacts or models  

## Project Structure

```
robot-setup/
├── setup.pdf                             # Setup to Deploy Stack
├── stack_one.yaml                        # CloudFormation template (Test)
├── stack_two.yaml                        # CloudFormation Prod (Prod)
├── README.md                             # This File

````

## Features

- Launches EC2 instance with security group configuration
- Creates S3 bucket for experiment data, model artifacts, or logs
- Reusable and parameterized for different environments (Test, Prod)
- Uses IAM best practices for least-privilege policies
- Follows declarative IaC methodology for full reproducibility

## How to Deploy

### Option 1: AWS Console

1. Open the AWS Management Console
2. Navigate to **CloudFormation > Create Stack**
3. Upload `stack_one.yaml or stack_two.yaml`
. Click **Next** through options and **Create Stack**

### Delete Stack

```bash
aws cloudformation delete-stack --stack-name RobotApp
```

## Screenshots

* Deployed EC2 instance
* Created S3 bucket
* CloudFormation Stack events

## What I Learned

* The power of **infrastructure-as-code** to scale cloud deployments
* CloudFormation YAML syntax, intrinsic functions, and stack dependencies
* Debugging stack creation issues using CloudFormation Events
* Designing reusable templates for future projects

## Anasieze Ikenna - Cloud Engineer
