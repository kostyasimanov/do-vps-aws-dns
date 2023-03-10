data "digitalocean_ssh_key" "company" {
  name = var.company_ssh_key_name
}