# Example - Server Provisioning on hcloud

## Description
The example in this directory will provision a server instance on Hetzner Cloud. Only the server resource is configured.

This example uses the defaults set within the module variables.

## Requirements
- Hetzner cloud api token created in the file API_TOKEN (the token will determine the Hetzner project that the cloud instance is created)
- SSH keys created in the files "id_ed25519_user.pub" and "id_ed25519_user"

## Usage
```bash
$ git clone https://github.com/hobbsAU/terraform-hetzner-hcloud.git
$ cd examples/server
$ ssh-keygen -t ed25519 -o -a 100 -f ./id_ed25519_user -C "ExampleKey"
$ echo "INSERT_API_TOKEN_HERE" > API_TOKEN
$ terraform init
$ terraform plan
$ terraform apply
```

Note: This example may create resources that cost money (hcloud server instance, for example). Run `terraform destroy` to remove these resources.

## Inputs
No inputs required.

## Outputs
| Name | Description |
|------|-------------|
| hcloud_dns_ptr | DNS PTR record |
| hcloud_floating_ipv4 | Floating IP address |
| hcloud_host_ipv4 | Host IPv4 |
| hcloud_volume_device | Volume device name |

