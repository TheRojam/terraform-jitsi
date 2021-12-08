variable hcloud_token {
 type = string
 description = "user provided hcloud api token"
}

# Required configuration
variable "ssh_public_key" {
  type        = string
  description = "SSH Public Key"
}

variable "ssh_key_id" {
  type 	= string
  description = "antons ssh_key on hetzner"
  default = "3137417"
}


# Optional configuration
variable "server" {
  type        = map(any)
  description = "Server configuration map"
  default = {
    name        = "hcloud-host"
    server_type = "cxp11"
    image       = "debian-11"
    location    = "fsn1"
    backups     = false
  }
}

variable "ssh_public_key_name" {
  type        = string
  description = "SSH Public Key Name"
  default     = "default"
}
