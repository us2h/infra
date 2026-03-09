resource "hcloud_server" "vm" {
  name        = var.vm_name
  image       = var.vm_image
  server_type = var.vm_server_type
  location    = var.vm_location

  public_net {
    ipv4_enabled = var.vm_ipv4_enabled
    ipv6_enabled = var.vm_ipv6_enabled
  }

  ssh_keys = var.ssh_keys
}
