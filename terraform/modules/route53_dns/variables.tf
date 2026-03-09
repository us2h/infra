variable "domain_name" {
  description = "The domain name in Route53"
  type        = string
}

variable "subdomains" {
  description = "List of subdomains to create"
  type        = list(string)
}

variable "vm_ipv4_address" {
  description = "IPv4 address of the Hetzner VM"
  type        = string
}

variable "vm_id" {
  description = "ID of the Hetzner VM"
  type        = string
}
