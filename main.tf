locals {
  fqdn = "${var.jitsi_sub_domain}.${var.domain_name}"
}

data "hcloud_ssh_key" "ssh_keys" { 
  name = "mbp.mueant.local"

}

resource "random_password" "password" {
  length = 16
  special = true
  override_special = "_%@"
}

data "template_file" "user_data" {  
  template = file("cloudinit.yaml")
  vars ={
    jitsi_sub_domain = var.jitsi_sub_domain
    jitsi_default_language = var.jitsi_default_language
    letsencrypt_account_email = var.letsencrypt_account_email
    fqdn = "${var.jitsi_sub_domain}.${var.domain_name}"
    random_password = random_password.password.result
  }
}

#
#
#
resource "hcloud_server" "server" {
  name        = "${var.jitsi_sub_domain}.${var.domain_name}" 
  image       = var.server.image
  server_type = var.server.server_type
  location    = var.server.location
  backups     = var.server.backups
  ssh_keys    = ["${data.hcloud_ssh_key.ssh_keys.id}"]
  user_data   = data.template_file.user_data.rendered
}

data "hcloud_server" "server"{
  name     = "${var.jitsi_sub_domain}.${var.domain_name}"
  depends_on = [hcloud_server.server]
}

resource "inwx_record" "domain2ipv4" {
  domain   = var.domain_name
  name     = var.jitsi_sub_domain
  type     = "A"
  value    = data.hcloud_server.server.ipv4_address 
  ttl      = 360
  priority = 10
  depends_on = [hcloud_server.server]

}
resource "inwx_record" "domain2ipv6" {
  domain   = var.domain_name
  name     = var.jitsi_sub_domain
  type     = "AAAA"
  value    = data.hcloud_server.server.ipv6_address 
  ttl      = 360
  priority = 10
  depends_on = [hcloud_server.server]

}
