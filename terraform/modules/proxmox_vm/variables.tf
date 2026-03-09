variable "vm_name" {
  type = string
}

variable "node_name" {
  type = string
}

variable "vm_id" {
  type = number
}

variable "cores" {
  type = number
}

variable "sockets" {
  type = number
}

variable "cpu_type" {
  type = string
}

variable "numa" {
  type = bool
}

variable "memory" {
  type = number
}

variable "ipv4_address" {
  type = string
}

variable "ipv4_gateway" {
  type = string
}

variable "username" {
  type = string
}

variable "ssh_keys" {
  type = list(string)
}

variable "datastore_id" {
  type = string
}

variable "disk_size" {
  type = number
}

variable "bridge" {
  type = string
}

variable "network_model" {
  type = string
}

variable "cloud_image_url" {
  type = string
}

variable "local_image_datastore_id" {
  type = string
}

variable "local_image_filename" {
  type = string
}

variable "additional_disk_enabled" {
  description = "Whether to add an additional disk"
  type        = bool
  default     = false
}

variable "additional_datastore_id" {
  description = "Datastore ID for the additional disk"
  type        = string
  default     = ""
}

variable "additional_disk_size" {
  description = "Size of the additional disk"
  type        = string
  default     = ""
}

variable "additional_disk_is_ssd" {
  description = "Whether the additional disk is an SSD"
  type        = bool
  default     = true
}

variable "additional_disk_backup_enabled" {
  description = "Whether to enable backups for the additional disk"
  type        = bool
  default     = false
}

variable "default_tags" {
  description = "Default tags applied to all VMs, set globally"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "VM-specific tags, merged with default_tags"
  type        = list(string)
  default     = []
}
