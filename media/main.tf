terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc07"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://<domain>/api2/json"
  pm_debug   = true
  # pm_tls_insecure = true
}

resource "proxmox_lxc_guest" "media" {
  name        = var.hostname
  privileged  = true
  target_node = "proxmox-1"
  password    = var.root_password
  template {
    file    = "ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    storage = "local"
  }
  tags = ["docker", "ubuntu"]
  cpu {
    cores = 4
  }
  memory = 4096
  swap   = 512
  startup_shutdown {}
  ssh_public_keys = file("~/.ssh/id_rsa.pub")
  features {
    privileged {
      nesting = true
    }
  }
  root_mount {
    size    = "8G"
    storage = "local-lvm"
  }
  mount {
    slot       = "mp0"
    storage    = "zfs-tank"
    guest_path = "/mnt/media"
    size       = "300G"
    backup     = false
    replicate  = false
    type       = "data"
  }
  network {
    id           = 0
    name         = "eth0"
    bridge       = "vmbr1"
    ipv4_address = "172.16.1.30/30"
    ipv4_gateway = "172.16.1.29"
    vlan_native  = 4
  }
}

resource "null_resource" "ansible" {
  triggers = {
    lxc_id        = proxmox_lxc_guest.media.id
    playbook_hash = filesha1("playbook.yml")
  }

  provisioner "local-exec" {
    command = <<-EOF
      ANSIBLE_HOST_KEY_CHECKING=False \
      ansible-playbook \
        -i ${split("/", proxmox_lxc_guest.media.network[0].ipv4_address)[0]}, \
        --user root \
        --timeout 10 \
        playbook.yml
    EOF
  }
}
