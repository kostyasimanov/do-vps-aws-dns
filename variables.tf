variable "do_token" {
  description = "Auth Token"
  sensitive   = true
}
variable "email_tag" {
  description = "Personal Email Tag"
  sensitive   = true
}
variable "current_task_tag" {
  description = "Current Task Tag"
}
variable "devops_tag" {
  default = "devops"
}
variable "company_ssh_key" {
  description = "Company SSH Pub Key"
  sensitive   = true
}
variable "personal_ssh_key" {
  description = "Personal SSH Pub Key"
  sensitive   = true
}
variable "domain_name" {
  description = "Domain name"
  type        = list(any)
  default     = ["vps01", "vps02"]
}
variable "company_ssh_key_name" {
  description = "SSH Key Name for searching by name"
}
variable "company_aws_dns_name" {
  description = "AWS Route53 DNS Name"
}
variable "login" {
  description = "Login Name"
  default     = ""
}
variable "aws_access_key" {
  description = "AWS Access Key"
  sensitive   = true
}
variable "aws_secret_key" {
  description = "AWS Secret Key"
  sensitive   = true
}
variable "root_password" {
  description = "Default root password"
  default     = ""
  sensitive   = true
}
variable "personal_ssh_key_path" {
  description = "Path to personal ssh key"
  default     = ""
}