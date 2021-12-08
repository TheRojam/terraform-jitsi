variable hcloud_token {
 type = string
 description = "user provided hcloud api token"
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
    server_type = "cpx11"
    image       = "debian-11"
    location    = "fsn1"
    backups     = false
  }
}

# DNS
#
# 
 variable "domain_name" {
   type = string
   description = "The name of the DNS zone at Hetzener DNS to create DNS records for the server."
   default = "therojam.cloud"
 }

variable "jitsi_sub_domain" {
  type = string
  default = "meet"
  description = "The subdomain where jitsi server will be reachable and SSL certificates are generated for."
}

#
# SSL
#
# For encryption of data in transit, a SSL certificate is generated 
# at Let's Encrypt and then the reverse proxy is configured to use it.
#
# In order to generate certificates with Let's Encrypt, an account
# needs to be created or reused. 
#
# Set "letsencrypt_account_email" to this email. If no Let's Encrypt
# account exists, one is created automatically.
#
variable "letsencrypt_account_email" {
  type = string
  description = "Email of Let's Encrypt account."
  default = "email@antonmueller.xyz"
}

#
# Jitsi
#
# The following variables can be used for customizing jitsi meet
# at least a little bit.
#
variable "jitsi_default_language" {
  type = string
  default = "en"
  description = "Default language of jitsi meet."
}

