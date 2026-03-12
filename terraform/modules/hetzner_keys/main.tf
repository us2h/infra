resource "hcloud_ssh_key" "this" {
  name       = var.ssh_key_name
  public_key = var.ssh_public_key
}
