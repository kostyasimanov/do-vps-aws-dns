data "external" "get_do_ssh_fingerprint" {
  program = ["bash", "./script/ssh_finger.sh"]
  query = {
    token = var.do_token
  }
}