resource "digitalocean_ssh_key" "personal" {
  name       = "kostyasimanov"
  public_key = var.personal_ssh_key
}

resource "digitalocean_droplet" "devops_vps" {
  count    = length(var.domain_name)
  image    = "ubuntu-22-04-x64"
  name     = "${element(var.domain_name, count.index)}-${count.index + 1}"
  region   = "fra1"
  size     = "s-1vcpu-1gb"
  tags     = [var.devops_tag, var.current_task_tag, var.email_tag]
  ssh_keys = [digitalocean_ssh_key.personal.fingerprint, data.digitalocean_ssh_key.company.fingerprint]
}

resource "aws_route53_record" "www" {
  count   = length(var.domain_name)
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "${var.login}-${count.index + 1}"
  type    = "A"
  ttl     = 300
  records = [element(local.ip_address, count.index)]
}