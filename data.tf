data "digitalocean_ssh_key" "company" {
  name = var.company_ssh_key_name
}
data "aws_route53_zone" "primary" {
  name = var.company_aws_dns_name
}