# Example usage for Hetzner cloud module

module "hcloud" {

  # Module source
  source = "github.com/hobbsAU/terraform-hetzner-hcloud"

  # Filename containing hcloud API TOKEN only
  hcloud_token = chomp(file("API_TOKEN"))

  # Define names to enable resources
  hcloud_server_name = "testserver-1"
  # hcloud_volume_name = "testvol-1"
  # hcloud_floatingip_name = "testip-1"
  # hcloud_fqdn_name = "ip.test.com"

  # Override defaults (optional)
  # hcloud_sshkey_name = "Terraform"
  # hcloud_sshkey_public = "id_ed25519_user.pub"
  # hcloud_server_os = "debian-10"
  # hcloud_server_type = "cx11"
  # hcloud_location = "nbg1"
  # hcloud_volume_size = "10"
  # hcloud_volume_format = "ext4"
  # system_userdata = "userdata.yml"
  # system_ssh_user  = "sshuser"
  # system_ssh_port = "22"
  # system_tz = "UTC"

  # Additional authorized SSH keys example (optional)
  # system_ssh_allowedkeys = [ 
  #"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG98Y8egOBwfMdR5Wv7Wam/Y4ww5nzukBHBGDx/vnJvm key1@system", 
  #"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG98Y8egOBwfMdR5Wv7Wam/Y4ww5nzukBHBGDx/vnJvm key2@system"
  #]
}


# Output variables
output "hcloud_host_ipv4" {
  description = "Host IP"
  value       = module.hcloud.host_ipv4
}
output "hcloud_floating_ipv4" {
  description = "Floating IP"
  value       = module.hcloud.floating_ipv4
}
output "hcloud_volume_device" {
  description = "Volume Device"
  value       = module.hcloud.volume_device
}
output "hcloud_dns_ptr" {
  description = "DNS PTR Record"
  value       = module.hcloud.dns_ptr
}
