locals {
  ###
  ### Proxmox provider configuration
  ###

  proxmox_endpoint          = "https://192.168.1.11:8006/"
  proxmox_username          = "root@pam"
  proxmox_tls_insecure      = true
  proxmox_ssh_agent_enabled = true
  proxmox_ssh_username      = "root"
  proxmox_ssh_nodes = [
    { name = "hv1", address = "192.168.1.11" },
    { name = "hv2", address = "192.168.1.12" },
  ]

  ###
  ### Global VM defaults
  ###

  sockets                  = 1
  cpu_type                 = "host"
  ipv4_gateway             = "192.168.1.1"
  bridge                   = "vmbr0"
  network_model            = "virtio"
  username                 = "root"
  ssh_keys                 = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF/NLaoutooC1CJC1TEVdtiaZ0lfdz/QAe2CfN693c9T"]
  cloud_image_url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  local_image_datastore_id = "nas"
  local_image_filename     = "noble-server-cloudimg-amd64.img"
  default_tags             = ["terraform"]
}
