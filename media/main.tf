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
  pm_debug = true
  # pm_tls_insecure = true
}

resource "proxmox_lxc" "media" {
    hostname     = var.hostname
    unprivileged = false
    target_node  = "proxmox-1"
    password     = var.root_password
    ostemplate   = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    onboot       = true
    start        = true
    tags         = "docker;ubuntu"
    cores = 4
    memory = 4096
    swap   = 512
    ssh_public_keys = file("~/.ssh/id_rsa.pub")
    features {
        nesting = true
    }
    rootfs {
        size    = "8G"
        storage = "local-lvm"
    }
    mountpoint {
        key     = "0"
        slot    = 0
        storage = "zfs-tank"
        mp      = "/mnt/media"
        size    = "300G"
        backup  = false
    }
    network {
        name = "eth0"
        bridge = "vmbr1"
        ip = "172.16.1.30/30"
        gw = "172.16.1.29"
        tag = 4
    }
}

resource "null_resource" "ansible" {
    triggers = {
        lxc_id = proxmox_lxc.media.id
        playbook_hash = filesha1("playbook.yml")
    }

    provisioner "local-exec" {
        command = <<-EOF
            sleep 60
            ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook \
                -i ${split("/", proxmox_lxc.media.network[0].ip)[0]}, \
                --user root playbook.yml
        EOF
    }
}