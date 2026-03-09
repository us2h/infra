terraform {
  source = "../../../modules/proxmox_vm"
}

locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals
}

inputs = {
  ###
  ### VM-specific configuration
  ###

  vm_name      = "test"
  node_name    = "hv1"
  vm_id        = 100
  cores        = 2
  numa         = false
  memory       = 2048
  datastore_id = "local-lvm"
  disk_size    = 50
  ipv4_address = "192.168.1.100/24"
  tags         = ["test"]

  ###
  ### Global defaults from env.hcl
  ###

  sockets                  = local.env.sockets
  cpu_type                 = local.env.cpu_type
  ipv4_gateway             = local.env.ipv4_gateway
  bridge                   = local.env.bridge
  network_model            = local.env.network_model
  username                 = local.env.username
  ssh_keys                 = local.env.ssh_keys
  cloud_image_url          = local.env.cloud_image_url
  local_image_datastore_id = local.env.local_image_datastore_id
  local_image_filename     = local.env.local_image_filename
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}
