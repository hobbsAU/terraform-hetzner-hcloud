# Terraform provisioning script for Hetzner Cloud instances

# Define Hetzner cloud provider
provider "hcloud" {
  token = var.hcloud_token
}

# Locals
locals {
  ssh_allowed_keys = flatten([[file(var.hcloud_sshkey_public)], var.system_ssh_allowedkeys])
}

# Define SSH keys
resource "hcloud_ssh_key" "this" {
  count      = var.hcloud_server_name != "" ? 1 : 0
  name       = var.hcloud_sshkey_name
  public_key = file(var.hcloud_sshkey_public)
}

# Cloud-init template used for bootstrapping server
data "template_file" "broker_cloudinit" {
  count    = var.hcloud_server_name != "" ? 1 : 0
  template = file(var.system_userdata)
  vars = {
    SYSTEM_TZ       = var.system_tz
    SSH_USER        = var.system_ssh_user
    SSH_PORT        = var.system_ssh_port
    SSH_ALLOWEDKEYS = "[ ${join(", ", [for s in local.ssh_allowed_keys : format("%q", s)])} ]"
  }
}

# Define server instance
resource "hcloud_server" "this" {
  count       = var.hcloud_server_name != "" ? 1 : 0
  name        = var.hcloud_server_name
  image       = var.hcloud_server_os
  server_type = var.hcloud_server_type
  location    = var.hcloud_location
  ssh_keys    = [hcloud_ssh_key.this[0].id]
  user_data   = data.template_file.broker_cloudinit[0].rendered

  # Wait for SSH
  provisioner "local-exec" {
    command = "while [[ \"$(ssh-keyscan -H -p ${var.system_ssh_port} ${self.ipv4_address} 2>/dev/null |wc -l)\" != 1 ]]; do echo \"Waiting for SSH..\"; sleep 5; done"
  }
  # Add SSH Host Keys
  provisioner "local-exec" {
    command = "ssh-keyscan -H -p ${var.system_ssh_port} ${self.ipv4_address} >> ~/.ssh/known_hosts"
  }
  # Remove SSH Host Keys
  provisioner "local-exec" {
    when    = destroy
    command = "ssh-keygen -R ${self.ipv4_address}"
  }

}

# Define storage volume
resource "hcloud_volume" "this" {
  count    = var.hcloud_volume_name != "" ? 1 : 0
  name     = var.hcloud_volume_name
  location = var.hcloud_location
  size     = var.hcloud_volume_size
  format   = var.hcloud_volume_format
}

# Attach storage volume to server instance
resource "hcloud_volume_attachment" "this" {
  count     = var.hcloud_server_name != "" && var.hcloud_volume_name != "" ? 1 : 0
  volume_id = hcloud_volume.this[0].id
  server_id = hcloud_server.this[0].id
  automount = true
}

# Define floating IPv4 address
resource "hcloud_floating_ip" "this" {
  count         = var.hcloud_floatingip_name != "" ? 1 : 0
  type          = "ipv4"
  home_location = var.hcloud_location
  description   = var.hcloud_floatingip_name
}

# Attach floating IPv4 to server instance
resource "hcloud_floating_ip_assignment" "this" {
  count          = var.hcloud_server_name != "" && var.hcloud_floatingip_name != "" ? 1 : 0
  floating_ip_id = hcloud_floating_ip.this[0].id
  server_id      = hcloud_server.this[0].id
}

# Setup RDNS for Floating IP
resource "hcloud_rdns" "this" {
  count          = var.hcloud_floatingip_name != "" && var.hcloud_fqdn_name != "" ? 1 : 0
  floating_ip_id = hcloud_floating_ip.this[0].id
  ip_address     = hcloud_floating_ip.this[0].ip_address
  dns_ptr        = var.hcloud_fqdn_name
}

# Setup RDNS for server IPv6
resource "hcloud_rdns_server" "this" {
  count          = var.hcloud_server_name != "" && var.hcloud_fqdn_name != "" ? 1 : 0
  server_id      = hcloud_server.this[0].id
  ip_address     = hcloud_server.this[0].ipv6_address
  dns_ptr        = var.hcloud_fqdn_name
}

