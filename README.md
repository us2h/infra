# us2h.home

Infrastructure-as-Code for a homelab using Terraform and Terragrunt. Manages virtual machines on Proxmox and Hetzner Cloud, and DNS records via AWS Route53.

## Project Structure

```
terraform/
├── environments/
│   ├── root.hcl              # Root Terragrunt config (backend, providers)
│   ├── .env                  # Credentials (gitignored)
│   ├── .env.example          # Environment variables template
│   └── homelab/
│       ├── env.hcl           # Homelab environment config
│       └── test/
│           └── terragrunt.hcl
└── modules/
    ├── proxmox_vm/           # Proxmox VM module
    ├── hetzner_vm/           # Hetzner Cloud VM module
    └── route53_dns/          # AWS Route53 DNS module
```

## Infrastructure

| Resource | Provider | Description |
|---|---|---|
| Proxmox VM | bpg/proxmox | VMs on local hypervisors (hv1, hv2) |
| Hetzner VM | hetznercloud/hcloud | Cloud VPS |
| DNS | AWS Route53 | A records and RDNS for servers |

## Remote State

Terraform state is stored in Wasabi S3-compatible storage:
- Bucket: `us2h-terraform-state`
- Endpoint: `https://s3.eu-central-2.wasabisys.com`
- Each environment has its own isolated state file

## Requirements

- [Terraform](https://www.terraform.io/) >= 1.0
- [Terragrunt](https://terragrunt.gruntwork.io/)
- Access to Proxmox API (`https://192.168.1.11:8006`)
- Wasabi credentials (for remote state)
- Optional: Hetzner API token, AWS credentials (for respective modules)

## Getting Started

1. Copy the environment variables template and fill in the values:
   ```bash
   cp terraform/environments/.env.example terraform/environments/.env
   ```

2. Load the variables:
   ```bash
   source terraform/environments/.env
   ```

3. Navigate to the desired environment and deploy:
   ```bash
   cd terraform/environments/homelab/test
   terragrunt init
   terragrunt plan
   terragrunt apply
   ```

## Environment Variables

| Variable | Description |
|---|---|
| `AWS_ACCESS_KEY_ID` | Wasabi access key (for remote state) |
| `AWS_SECRET_ACCESS_KEY` | Wasabi secret key |
| `TF_VAR_proxmox_password` | Proxmox user password |

## Modules

### proxmox_vm

Creates a VM on Proxmox with cloud-init:
- Ubuntu cloud image (Noble)
- Static IP, SSH key
- Automatic QEMU guest agent installation
- Optional additional disk mounted at `/mnt/disk`

### hetzner_vm

Creates a VPS on Hetzner Cloud:
- Configurable server type and location
- IPv4/IPv6, SSH key

### route53_dns

Manages DNS records:
- A records for subdomains
- RDNS for Hetzner servers
- TTL: 300 seconds
