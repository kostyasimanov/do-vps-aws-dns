terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

locals {
  ip_address        = digitalocean_droplet.devops_vps[*].ipv4_address
  customer_vps_name = aws_route53_record.www[*].fqdn
  vps_info = [
    for i in range(length(var.devs)) :
    {
      index         = i
      dns_name      = "${var.login}-${var.devs[i]}.${data.aws_route53_zone.primary.name}"
      ip_address    = digitalocean_droplet.rebrain-devops[i].ipv4_address
      root_password = element(random_string.password[*].result, i)
    }
  ]
}
