terraform {
  required_version = "~> 0.14"

  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
    template = "~> 2.2"
  }
}

