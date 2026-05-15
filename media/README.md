# Media Server

The media server contains these services:

- Jellyfin
- qBittorrent
- Sonarr
- Radarr
- Bazarr
- Jackett

## Requirements

In the provider host, the dependencies below must be installed:

- Terraform - [Terraform Installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Ansible - [Ansible Installation Guide](https://docs.ansible.com/projects/ansible/latest/installation_guide/intro_installation.html)

Install the Ansible collection dependencies:

```bash
ansible-galaxy install -r requirements.yml
```

## Terraform + Ansible Provision

The Ansible automation provision is called by Terraform, running just the
Terraform will deploy the entire stack of media services.

```bash
terraform init
terraform plan
terraform apply
```
