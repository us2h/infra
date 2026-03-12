terraform {
  source = "../../../modules/proxmox_vm"
}

locals {
  env       = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals
  node_name = "hv1"
}

inputs = {
  ###
  ### VM-specific configuration
  ###

  vm_name          = "k8s-worker-node-1"
  node_name        = local.node_name
  proxmox_endpoint = local.env.proxmox_endpoints[local.node_name]
  vm_id            = 121
  cores            = 8
  numa             = true
  memory           = 16384
  datastore_id     = "disk"
  disk_size        = 200
  ipv4_address     = "192.168.1.121/24"
  tags             = ["k8s"]

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
  path = find_in_parent_folders("proxmox_root.hcl")
}
