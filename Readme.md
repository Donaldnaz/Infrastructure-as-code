# GCP Cloud Functions
This Terraform module deploys a **Cloud Function** triggered by a **Cloud Storage bucket** event.

# Resources Created
- Google Cloud Function (2nd Gen)
- Archive file from source code
- Cloud Storage Bucket Object
- Event trigger for bucket object creation
- IAM permissions assumed by service accounts

# GCP Cloud Functions Terraform Module

This Terraform module deploys a **Google Cloud Function (2nd Gen)** that is triggered by an event on a **Cloud Storage Bucket**. The module handles source archiving, IAM permissions, and event trigger configuration for a streamlined serverless deployment on Google Cloud Platform (GCP).

---

##  Resources Created

This module creates the following resources:

-  **Google Cloud Function (2nd Gen)** — Deploys your serverless function code.
-  **Archive File** — Zips the source code for deployment.
-  **Cloud Storage Bucket Object** — Stores the zipped function code.
-  **Event Trigger** — Triggers the function on Cloud Storage `object.finalize` events (i.e., object creation).
-  **IAM Permissions** — Grants required roles to the Cloud Function's service account for accessing Cloud Storage and invoking the function.

---

## 📌 Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.3 |
| Google Provider | >= 5.0 |
