output "vm_name" {
  description = "The name of the VM"
  value       = hcloud_server.vm.name
}

output "ipv4_address" {
  description = "The IPv4 address of the VM"
  value       = hcloud_server.vm.ipv4_address
}
