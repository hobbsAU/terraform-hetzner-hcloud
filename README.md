# Hetzner hcloud Terraform module

## Description
Terraform module that enables Create, Retrieve, Update and Delete (CRUD) operations for resources on [Hetzner Cloud](https://www.hetzner.com/cloud). You could use this as part of an Infrastructure as Code (IaC) pipeline to create a virtual Linux server on Hetzner Cloud.

## Provider Resources
The following resources are supported:
- [hcloud_server](https://www.terraform.io/docs/providers/hcloud/r/server.html)
- [hcloud_volume](https://www.terraform.io/docs/providers/hcloud/r/volume.html)
- [hcloud_ssh_key](https://www.terraform.io/docs/providers/hcloud/r/ssh_key.html)
- [hcloud_floating_ip](https://www.terraform.io/docs/providers/hcloud/r/floating_ip.html)
- [hcloud_rdns](https://www.terraform.io/docs/providers/hcloud/r/rdns.html)


## Requirements
| Name | Version |
|------|---------|
| terraform | ~> 0.12 |
| template | ~> 2.1 |
| hcloud | ~> 1.16 |


## Usage
See [Examples](#examples) for extended usage.

```hcl
# Example usage for Hetzner cloud module

module "hcloud" {

  # Module source
  source = "github.com/hobbsAU/terraform-hetzner-hcloud"

  # File containing hcloud API TOKEN only
  hcloud_token = chomp(file("API_TOKEN"))

  # Define names to enable resources
  # hcloud_server_name = "testserver-1"
  # hcloud_volume_name = "testvol-1"
  # hcloud_floatingip_name = "testip-1"
  # hcloud_fqdn_name = "ip.test.com"

}
```



### Conditional creation
Sometimes you need to have a way to create resources conditionally however Terraform does not allow to use `count` inside `module` block. This module only creates resources if any `_name` variables are set. 

The following example does not create any resources.

```hcl
module "hcloud" {

  # Module source
  source = "github.com/hobbsAU/terraform-hetzner-hcloud"

  # File containing hcloud API TOKEN only
  hcloud_token = chomp(file("API_TOKEN"))

  # Define names to enable resources
  # hcloud_server_name = "testserver-1"
  # hcloud_volume_name = "testvol-1"
  # hcloud_floatingip_name = "testip-1"
  # hcloud_fqdn_name = "ip.test.com"
```

## Examples
More detailed examples are contained in module/examples.

## Versioning
This module uses [semantic versioning](https://semver.org/) to avoid compatibility problems.

## Authors
Module is created and maintained by [hobbsAU](https://github.com/hobbsAU).

