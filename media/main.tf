terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.92.0"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_endpoint
  username = var.proxmox_username
  password = var.proxmox_password
  insecure = false
}

resource "proxmox_virtual_environment_container" "media" {
  vm_id       = var.vm_id
  node_name   = "proxmox-1"
  description = "Media Container, managed by Terraform"
  
  initialization {
    hostname = var.hostname
    user_account {
      password = var.root_password
      keys     = [file("~/.ssh/id_rsa.pub")]
    }
    ip_config {
      ipv4 {
        address = var.ipv4_address
        gateway = var.ipv4_gateway
      }
    }
    dns {
      servers = [var.ipv4_gateway, "8.8.8.8", "1.1.1.1"]
    }
  }
  
  operating_system {
    template_file_id = var.template_file_id
    type             = var.operational_system_type
  }
  
  cpu {
    cores = 4
  }
  
  memory {
    dedicated = 4096
    swap      = 512
  }

  network_interface {
    name    = "veth0"
    bridge  = "vmbr1"
    vlan_id = 4
  }
  
  disk {
    datastore_id = "local-lvm"
    size         = 16
  }
  
  mount_point {
    path   = "/mnt/media"
    volume = "zfs-tank"
    size   = "300G"
  }

  device_passthrough {
    path = "/dev/dri/renderD128"
    gid  = 993
  }

  unprivileged = true
  
  features {
    nesting = true
  }
}

resource "null_resource" "ansible" {
  triggers = {
    container_id  = proxmox_virtual_environment_container.media.id
    playbook_hash = filesha1("playbook.yml")
  }

  provisioner "local-exec" {
    command = <<-EOF
      ANSIBLE_HOST_KEY_CHECKING=False \
      ansible-playbook \
        -i ${split("/", var.ipv4_address)[0]}, \
        --user root \
        --timeout 10 \
        playbook.yml
    EOF
  }
}
