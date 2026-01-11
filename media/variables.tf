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
  type    = string
  default = "https://proxmox_domain_or_ip:port"
}
variable "proxmox_api_token" {
  type    = string
  default = "root@pam!terraform=your_token_here"
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
