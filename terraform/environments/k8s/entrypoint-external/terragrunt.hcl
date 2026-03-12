terraform {
  source = "../../../modules/hetzner_vm"
}

dependency "ssh-keys" {
  config_path = "../hetzner-ssh-keys"
}

inputs = {
  vm_name        = "k8s-entrypoint-external"
  vm_image       = "ubuntu-24.04"
  vm_server_type = "cx23"
  vm_location    = "nbg1"

  vm_ipv4_enabled = true
  vm_ipv6_enabled = false

  ssh_keys = [tostring(dependency.ssh-keys.outputs.ssh_key_id)]
}

include "root" {
  path = find_in_parent_folders("hcloud_root.hcl")
}
