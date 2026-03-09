variable "vm_name" {
  type        = string
  description = "The name of the virtual machine"
}

variable "vm_image" {
  type        = string
  description = "The image of the virtual machine"
}

variable "vm_server_type" {
  type        = string
  description = "The server type of the virtual machine"
}

variable "vm_location" {
  type        = string
  description = "The location of the virtual machine"
}

variable "vm_ipv4_enabled" {
  type        = bool
  description = "Whether the public IPv4 address is enabled"
  default     = true
}

variable "vm_ipv6_enabled" {
  type        = bool
  description = "Whether the public IPv6 address is enabled"
  default     = false
}

variable "ssh_keys" {
  type        = list(string)
  description = "The list of SSH keys"
}
