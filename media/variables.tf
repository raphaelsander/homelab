variable "hostname" {
  type    = string
  default = "media"
}
variable "root_password" {
  type    = string
  default = "password"
  sensitive = true
}
variable "vm_id" {
  type    = string
}
variable "proxmox_endpoint" {
  description = "Proxmox VE API endpoint URL, e.g., https://proxmox_domain_or_ip:port"
  type    = string
}
variable "proxmox_username" {
  type    = string
  default = "root@pam"
}
variable "proxmox_password" {
  description = "Proxmox password for 'root@pam' user by default."
  type    = string
  sensitive = true
}
variable "ipv4_address" {
  type    = string
  default = "172.16.1.30/30"
}
variable "ipv4_gateway" {
  type    = string
  default = "172.16.1.29"
}
variable "template_file_id" {
  type    = string
  default = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
}
variable "operational_system_type" {
  type    = string
  default = "ubuntu"
}
variable "node_name" {
  type    = string
  default = "pve-1"
}
