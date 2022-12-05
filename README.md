# terraform-digitalocean-module

Terraform module for managing DigitalOcean Droplets and related resources

Info wil be added latter.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.25.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.23.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_droplet.droplet](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_firewall.firewall](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall) | resource |
| [digitalocean_loadbalancer.loadbalancer](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/loadbalancer) | resource |
| [digitalocean_project.project](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project) | resource |
| [digitalocean_project_resources.project_resource](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project_resources) | resource |
| [digitalocean_reserved_ip.reserved_ip](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/reserved_ip) | resource |
| [digitalocean_reserved_ip_assignment.reserved_ip_assignment](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/reserved_ip_assignment) | resource |
| [digitalocean_spaces_bucket.space](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/spaces_bucket) | resource |
| [digitalocean_volume.volume](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume) | resource |
| [digitalocean_volume_attachment.volume_attachment](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume_attachment) | resource |
| [digitalocean_ssh_keys.keys](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/ssh_keys) | data source |
| [digitalocean_vpc.vpc](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_block_storage_filesystem_label"></a> [block\_storage\_filesystem\_label](#input\_block\_storage\_filesystem\_label) | Label of the block storage to create. | `string` | `"data"` | no |
| <a name="input_block_storage_filesystem_type"></a> [block\_storage\_filesystem\_type](#input\_block\_storage\_filesystem\_type) | Type of the block storage to create. | `string` | `"xfs"` | no |
| <a name="input_block_storage_size"></a> [block\_storage\_size](#input\_block\_storage\_size) | Size of the block storage to create. | `number` | `0` | no |
| <a name="input_droplet_backups"></a> [droplet\_backups](#input\_droplet\_backups) | Enable backups for the droplet. | `bool` | `false` | no |
| <a name="input_droplet_count"></a> [droplet\_count](#input\_droplet\_count) | Number of droplets to create. | `number` | `1` | no |
| <a name="input_droplet_graceful_shutdown"></a> [droplet\_graceful\_shutdown](#input\_droplet\_graceful\_shutdown) | Graceful shutdown of the droplet. If set to true, the droplet will be shut down gracefully. Otherwise, it will be terminated. | `bool` | `false` | no |
| <a name="input_droplet_image"></a> [droplet\_image](#input\_droplet\_image) | Image slug for the desired image. See 'available-images.txt' for a list. | `string` | `"debian-11-x64"` | no |
| <a name="input_droplet_ipv6"></a> [droplet\_ipv6](#input\_droplet\_ipv6) | Enable IPv6 for the droplet. | `bool` | `false` | no |
| <a name="input_droplet_monitoring"></a> [droplet\_monitoring](#input\_droplet\_monitoring) | Enable monitoring for the droplet. If set to true, the droplet will be monitored. Otherwise, it will not be monitored. | `bool` | `true` | no |
| <a name="input_droplet_name"></a> [droplet\_name](#input\_droplet\_name) | Name of the DigitalOcean droplet. Must be unique. | `string` | n/a | yes |
| <a name="input_droplet_resize_disk"></a> [droplet\_resize\_disk](#input\_droplet\_resize\_disk) | Resize the disk to the specified size. | `bool` | `true` | no |
| <a name="input_droplet_size"></a> [droplet\_size](#input\_droplet\_size) | Droplet size | `string` | `"s-1vcpu-1gb"` | no |
| <a name="input_droplet_ssh_keys"></a> [droplet\_ssh\_keys](#input\_droplet\_ssh\_keys) | List of SSH IDs or fingerprints to enable. They must already exist in your DO account. | `list(string)` | `[]` | no |
| <a name="input_droplet_tags"></a> [droplet\_tags](#input\_droplet\_tags) | Tags to set on the droplet. | `list(string)` | `[]` | no |
| <a name="input_droplet_user_data"></a> [droplet\_user\_data](#input\_droplet\_user\_data) | User data to pass to the droplet. | `string` | `""` | no |
| <a name="input_droplet_vpc_uuid"></a> [droplet\_vpc\_uuid](#input\_droplet\_vpc\_uuid) | VPC UUID to assign the droplet to. | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to be created. | `string` | `"Development"` | no |
| <a name="input_firewall_inbound_rules"></a> [firewall\_inbound\_rules](#input\_firewall\_inbound\_rules) | Inbound firewall rules. | <pre>list(object({<br>    protocol         = string<br>    port_range       = string<br>    source_addresses = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_firewall_outbound_rule"></a> [firewall\_outbound\_rule](#input\_firewall\_outbound\_rule) | Outbound firewall rules. | <pre>list(object({<br>    protocol              = string<br>    port_range            = string<br>    destination_addresses = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_loadbalancer"></a> [loadbalancer](#input\_loadbalancer) | Enable load balancer for the droplet. | `bool` | `false` | no |
| <a name="input_loadbalancer_algorithm"></a> [loadbalancer\_algorithm](#input\_loadbalancer\_algorithm) | Algorithm to use for the load balancer. | `string` | `"round_robin"` | no |
| <a name="input_loadbalancer_enable_backend_keepalive"></a> [loadbalancer\_enable\_backend\_keepalive](#input\_loadbalancer\_enable\_backend\_keepalive) | Enable backend keepalive for the load balancer. | `bool` | `false` | no |
| <a name="input_loadbalancer_enable_proxy_protocol"></a> [loadbalancer\_enable\_proxy\_protocol](#input\_loadbalancer\_enable\_proxy\_protocol) | Enable proxy protocol for the load balancer. | `bool` | `false` | no |
| <a name="input_loadbalancer_forwarding_rule"></a> [loadbalancer\_forwarding\_rule](#input\_loadbalancer\_forwarding\_rule) | List of forwarding\_rule maps to apply to the loadbalancer. | `map(any)` | <pre>{<br>  "entry_port": 80,<br>  "entry_protocol": "http",<br>  "target_port": 80,<br>  "target_protocol": "http",<br>  "tls_passthrough": false<br>}</pre> | no |
| <a name="input_loadbalancer_healthcheck"></a> [loadbalancer\_healthcheck](#input\_loadbalancer\_healthcheck) | A healthcheck block to be assigned to the Load Balancer. Only 1 healthcheck is allowed. | `map(any)` | <pre>{<br>  "check_interval_seconds": 10,<br>  "healthy_threshold": 5,<br>  "path": "/",<br>  "port": 80,<br>  "protocol": "http",<br>  "response_timeout_seconds": 5,<br>  "unhealthy_threshold": 3<br>}</pre> | no |
| <a name="input_loadbalancer_name"></a> [loadbalancer\_name](#input\_loadbalancer\_name) | Name of the load balancer to create. | `string` | `""` | no |
| <a name="input_loadbalancer_redirect_http_to_https"></a> [loadbalancer\_redirect\_http\_to\_https](#input\_loadbalancer\_redirect\_http\_to\_https) | Redirect HTTP to HTTPS for the load balancer. | `bool` | `false` | no |
| <a name="input_loadbalancer_size_unit"></a> [loadbalancer\_size\_unit](#input\_loadbalancer\_size\_unit) | Size of the load balancer to create. | `number` | `1` | no |
| <a name="input_loadbalancer_sticky_sessions"></a> [loadbalancer\_sticky\_sessions](#input\_loadbalancer\_sticky\_sessions) | A sticky\_sessions block to be assigned to the Load Balancer. Only 1 sticky\_sessions block is allowed. | `map(any)` | <pre>{<br>  "cookie_name": null,<br>  "cookie_ttl_seconds": null,<br>  "type": "none"<br>}</pre> | no |
| <a name="input_loadbalancer_vpc_uuid"></a> [loadbalancer\_vpc\_uuid](#input\_loadbalancer\_vpc\_uuid) | VPC UUID to assign the load balancer to. | `string` | `""` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project to assign the droplet to. | `string` | `""` | no |
| <a name="input_project_purpose"></a> [project\_purpose](#input\_project\_purpose) | Purpose of the project to assign the droplet to. | `string` | `"Web Application"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region to assign the droplet to. | `string` | `"fra1"` | no |
| <a name="input_reserved_ip"></a> [reserved\_ip](#input\_reserved\_ip) | Reserved IP to assign to the droplet. | `bool` | `false` | no |
| <a name="input_reserved_ip_assign"></a> [reserved\_ip\_assign](#input\_reserved\_ip\_assign) | Reserved IP assigned | `bool` | `false` | no |
| <a name="input_reserved_ip_count"></a> [reserved\_ip\_count](#input\_reserved\_ip\_count) | Reserved IP count | `number` | `0` | no |
| <a name="input_space_acl"></a> [space\_acl](#input\_space\_acl) | ACL to assign the space to. | `string` | `"private"` | no |
| <a name="input_space_force_destroy"></a> [space\_force\_destroy](#input\_space\_force\_destroy) | Force destroy the space. | `bool` | `false` | no |
| <a name="input_space_name"></a> [space\_name](#input\_space\_name) | Name of the space to assign the droplet to. | `list(string)` | `[]` | no |
| <a name="input_space_region"></a> [space\_region](#input\_space\_region) | Region to assign the space to. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_droplets"></a> [droplets](#output\_droplets) | Information about the created droplets. |
| <a name="output_firewalls"></a> [firewalls](#output\_firewalls) | Information about the created firewalls. |
| <a name="output_loadbalancer"></a> [loadbalancer](#output\_loadbalancer) | Information about the created load balancer. |
| <a name="output_price_monthly"></a> [price\_monthly](#output\_price\_monthly) | Mothly cost. |
| <a name="output_spaces"></a> [spaces](#output\_spaces) | Information about the created spaces. |
| <a name="output_volumes"></a> [volumes](#output\_volumes) | Information about the created volumes. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
