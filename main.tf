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
}
