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

  connection {
    type        = "ssh"
    user        = "root"
    host        = self.ipv4_address
    private_key = file(var.personal_ssh_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo echo -e 'root:${element(random_string.password[*].result, count.index)}' | sudo chpasswd",
      "sleep 20",
      "sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/50-cloud-init.conf",
      "sudo systemctl restart ssh",
    ]
  }

  provisioner "local-exec" {
    command = "Add-Content '${var.login}-${count.index+1}.${data.aws_route53_zone.primary.name} root ${element(random_string.password[*].result, count.index)}' -Path passwords.txt"
    interpreter = ["PowerShell", "-Command"]
  }
}

resource "aws_route53_record" "www" {
  count   = length(var.domain_name)
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "${var.login}-${count.index + 1}"
  type    = "A"
  ttl     = 300
  records = [element(local.ip_address, count.index)]
}

resource "random_string" "password" {
  count = length(var.domain_name)
  length = 16
  override_special = "!@#$%&"
}