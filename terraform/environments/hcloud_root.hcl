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
    provider "hcloud" {
      token = var.hcloud_token
    }

    variable "hcloud_token" {
      description = "Hetzner Cloud API token"
      type        = string
      sensitive   = true
    }
  EOT
}
