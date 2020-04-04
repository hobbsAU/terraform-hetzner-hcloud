# All variables are declared and defaults defined here

# hcloud provider variables
variable "hcloud_token" {
  description = "This is the Hetzner Cloud API Token, can also be specified with the HCLOUD_TOKEN environment variable."
  type        = string
  default     = ""
}

variable "hcloud_sshkey_name" {
  description = "Provides a Hetzner Cloud SSH key resource to manage SSH keys for server access."
  type        = string
  default     = "Terraform"
}

variable "hcloud_sshkey_public" {
  description = "Location of file containing the public key."
  type        = string
  default     = "id_ed25519_user.pub"
}

variable "hcloud_server_name" {
  description = "Sets name and controls if server instance should be created (it affects almost all resources)."
  type        = string
  default     = ""
}

variable "hcloud_server_os" {
  description = "Operating system image."
  type        = string
  default     = "debian-10"
}

variable "hcloud_server_type" {
  description = "Server types can be found here: https://www.hetzner.com/cloud"
  type        = string
  default     = "cx11"
}

variable "hcloud_location" {
  description = "Locations: Falkenstein fsn1; Nuremberg nbg1; Helsinki hel1."
  type        = string
  default     = "nbg1"
}

variable "hcloud_volume_name" {
  description = "Sets name and controls if volume should be created"
  type        = string
  default     = ""
}

variable "hcloud_volume_size" {
  description = "Size of the volume (in GB)."
  type        = string
  default     = "10"
}

variable "hcloud_volume_format" {
  description = "Format volume after creation in xfs or ext4 format."
  type        = string
  default     = "ext4"
}

variable "hcloud_floatingip_name" {
  description = "Sets name and controls if floating IP should be created."
  type        = string
  default     = ""
}

variable "hcloud_fqdn_name" {
  description = "Sets name and controls if RDNS entry for floating IP should be created."
  type        = string
  default     = ""
}

variable "system_userdata" {
  description = "Cloud-init user data to use during server creation."
  type        = string
  default     = "userdata.yml"
}

variable "system_ssh_user" {
  description = "Admin user."
  type        = string
  default     = "sshuser"
}

variable "system_ssh_port" {
  description = "SSH port."
  type        = string
  default     = "22"
}

variable "system_ssh_allowedkeys" {
  description = "List of SSH keys in plain text format."
  type        = list(string)
  default     = []
}

variable "system_tz" {
  description = "Timezone, defaults to UTC."
  type        = string
  default     = "UTC"
}


