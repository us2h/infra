output "ssh_key_id" {
  description = "The ID of the SSH key"
  value       = hcloud_ssh_key.this.id
}

output "ssh_key_name" {
  description = "The name of the SSH key"
  value       = hcloud_ssh_key.this.name
}
