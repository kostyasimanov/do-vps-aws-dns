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
variable "personal_ssh_key" {
  description = "Personal SSH Pub Key"
  sensitive   = true
}
variable "domain_name" {
  description = "Domain name"
  default     = "vps.company"
}
variable "company_ssh_key_name" {
  description = "SSH Key Name for searching by name"
}