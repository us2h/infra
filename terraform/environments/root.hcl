locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env      = local.env_vars.locals
}

inputs = {
  default_tags = local.env.default_tags
}

remote_state {
  backend = "s3"
  config = {
    bucket                      = "us2h-terraform-state"
    key                         = "${path_relative_to_include()}/terraform.tfstate"
    region                      = "us-east-1"
    endpoint                    = "https://s3.eu-central-2.wasabisys.com"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOT
    provider "proxmox" {
      endpoint = var.proxmox_endpoint
      username = "${local.env.proxmox_username}"
      password = var.proxmox_password
      insecure = ${local.env.proxmox_tls_insecure}

      ssh {
        agent    = ${local.env.proxmox_ssh_agent_enabled}
        username = "${local.env.proxmox_ssh_username}"

        %{~ for node in local.env.proxmox_ssh_nodes ~}
        node {
          name    = "${node.name}"
          address = "${node.address}"
        }
        %{~ endfor ~}
      }
    }

    variable "proxmox_endpoint" {
      description = "Proxmox API endpoint URL"
      type        = string
    }

    variable "proxmox_password" {
      description = "Proxmox password"
      type        = string
      sensitive   = true
    }
  EOT
}
