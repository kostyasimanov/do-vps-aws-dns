provider "digitalocean" {
  token = var.do_token
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  default_tags {
    tags = {
      Devops = var.devops_tag
      Task   = var.current_task_tag
      Email  = var.email_tag
    }
  }
}