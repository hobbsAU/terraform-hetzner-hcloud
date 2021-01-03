# All output variables are declared here
output "floating_ipv4" {
  value = hcloud_floating_ip.this.*.ip_address
}
output "host_ipv4" {
  value = hcloud_server.this.*.ipv4_address
}
output "volume_device" {
  value = hcloud_volume.this.*.linux_device
}
output "dns_ptr" {
  value = hcloud_rdns.rdns_floating.*.dns_ptr
}
