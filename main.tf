resource "hcloud_ssh_key" "default" {
  id      = var.ssh_key_id
}



resource "hcloud_server" "server" {
  name        = var.server.name
  image       = var.server.image
  server_type = var.server.server_type
  location    = var.server.location
  backups     = var.server.backups
  ssh_keys    = data.ssh_keys.id 
  user_data = templatefile("${path.module}/user_data/${var.server.image}.yaml", {
    docker_compose_version = var.docker_compose_version
    volume_filesystem      = var.volume_filesystem
    filesystem_cmd_opt     = var.volume_filesystem == "xfs" ? "-f" : "-F"
    linux_device           = hcloud_volume.master.linux_device
    mount_dir_name         = hcloud_volume.master.name
  })
}
