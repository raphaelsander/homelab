variable "hostname" {
  type    = string
  default = "media"
}
variable "root_password" {
  type    = string
  default = "password"
  sensitive = true
}