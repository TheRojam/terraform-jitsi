terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
    inwx ={
     source = "ofzhur/inwx"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

provider "inwx" {
  username = var.inwx_username
  password = var.inwx_password
}
