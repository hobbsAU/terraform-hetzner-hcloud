terraform {
  required_version = "~> 0.14"

  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.32.1"
    }
    template = "~> 2.2"
  }
}

