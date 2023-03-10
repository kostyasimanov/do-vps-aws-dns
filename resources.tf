resource "digitalocean_ssh_key" "personal" {
  name       = "kostyasimanov"
  public_key = var.personal_ssh_key
}

resource "digitalocean_tag" "devops" {
  name = "devops"
}

resource "digitalocean_tag" "current_task" {
  name = var.current_task_tag
}

resource "digitalocean_tag" "email" {
  name = var.email_tag
}

resource "digitalocean_droplet" "devops_vps" {
  image  = "ubuntu-22-04-x64"
  name   = "devops.${var.domain_name}"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  tags = [digitalocean_tag.devops.id, digitalocean_tag.current_task.id, digitalocean_tag.email.id]
  ssh_keys = [digitalocean_ssh_key.personal.fingerprint, data.digitalocean_ssh_key.company.fingerprint]
}