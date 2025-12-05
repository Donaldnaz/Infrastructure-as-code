# GCP VPC Networking Terraform Module

This Terraform module provisions a **custom VPC network** on **Google Cloud Platform (GCP)**, complete with a **public subnet**, **Cloud Router**, and **dynamic firewall rules**. It optionally supports GKE subnets and is designed to be flexible and production-ready.

## Resources Created

The following resources are created by this module:

| Resource | Description |
|----------|-------------|
| `google_compute_network` | Custom VPC network (non-auto mode) |
| `google_compute_subnetwork` | Public subnet within the custom VPC |
| `google_compute_router` | Cloud Router for dynamic routing |
| `google_compute_firewall` | Dynamic ingress firewall rules for SSH, ICMP, HTTP, etc. |
| *(Optional)* GKE subnet | Commented out and can be enabled as needed |

## Features

- Custom VPC with explicitly defined subnets
- Firewall rules for secure and dynamic traffic control
- Cloud Router for dynamic BGP support (e.g., for VPNs or hybrid connectivity)
- Ready to support **GKE subnet** configuration (predefined but disabled)
- Designed for modular reuse across environments

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) v1.3 or higher
- Google Cloud project with billing enabled
- Proper IAM roles (e.g., `Network Admin`, `Compute Admin`)


## Security Best Practices

* Restrict firewall rules by IP ranges (e.g., use your IP instead of `0.0.0.0/0`)
* Separate subnets for public-facing and internal resources
* Use service perimeters (VPC-SC) for sensitive environments

## Clean Up

To remove the network and all associated resources:

```bash
terraform destroy
```

## Author

**Anasieze Ikenna – Cloud Engineer**
