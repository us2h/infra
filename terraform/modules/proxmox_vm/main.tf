resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.node_name

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: ${var.vm_name}
    users:
      - default
      - name: ${var.username}
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${join("\n          - ", var.ssh_keys)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
        - apt update
        - apt install -y qemu-guest-agent
        - systemctl enable qemu-guest-agent
        - systemctl start qemu-guest-agent
        - apt upgrade -y
        %{ if var.additional_disk_enabled }
        - mkfs.ext4 /dev/sdb
        - mkdir -p /mnt/disk
        - UUID=$(blkid -s UUID -o value /dev/sdb)
        - echo "# Additional disk for storage" >> /etc/fstab
        - echo "UUID=$UUID /mnt/disk ext4 defaults 0 0" >> /etc/fstab
        - mount -a
        %{ endif }
        - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "cloud-config-${var.node_name}-${var.vm_name}.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  name      = var.vm_name
  node_name = var.node_name
  vm_id     = var.vm_id
  tags      = concat(var.default_tags, var.tags)

  agent {
    enabled = true
  }

  operating_system {
    type = "l26"
  }

  cpu {
    cores   = var.cores
    sockets = var.sockets
    type    = var.cpu_type
    numa    = var.numa
  }

  memory {
    dedicated = var.memory
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.ipv4_address
        gateway = var.ipv4_gateway
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id

  }

  # Disk with OS
  disk {
    datastore_id = var.datastore_id
    file_id      = "${var.local_image_datastore_id}:iso/${var.local_image_filename}"
    interface    = "scsi0"
    ssd          = true
    size         = var.disk_size
  }

  # Conditionally attach an additional disk for storage
  dynamic "disk" {
    for_each = var.additional_disk_enabled ? [1] : []
    content {
      datastore_id = var.additional_datastore_id
      size         = var.additional_disk_size
      interface    = "scsi1"
      ssd          = var.additional_disk_is_ssd
      backup       = var.additional_disk_backup_enabled
    }
  }

  network_device {
    bridge = var.bridge
    model  = var.network_model
  }
}
