# Region:
variable "region" {
  description = "Region to assign the droplet to."
  type        = string
  default     = "fra1"
}

# Droplet variables:
variable "droplet_count" {
  description = "Number of droplets to create."
  type        = number
  default     = 1
}

variable "droplet_image" {
  description = "Image slug for the desired image. See 'available-images.txt' for a list."
  type        = string
  default     = "debian-11-x64"
}

variable "droplet_name" {
  type        = string
  description = "Name of the DigitalOcean droplet. Must be unique."
}

variable "droplet_size" {
  description = "Droplet size"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "droplet_backups" {
  description = "Enable backups for the droplet."
  type        = bool
  default     = false
}

variable "droplet_monitoring" {
  description = "Enable monitoring for the droplet. If set to true, the droplet will be monitored. Otherwise, it will not be monitored."
  type        = bool
  default     = true
}

variable "droplet_ipv6" {
  description = "Enable IPv6 for the droplet."
  type        = bool
  default     = false
}

variable "droplet_vpc_uuid" {
  description = "VPC UUID to assign the droplet to."
  type        = string
  default     = ""
}

variable "droplet_ssh_keys" {
  description = "List of SSH IDs or fingerprints to enable. They must already exist in your DO account."
  type        = list(string)
  default     = []
}

variable "droplet_resize_disk" {
  description = "Resize the disk to the specified size."
  type        = bool
  default     = true
}

variable "droplet_tags" {
  description = "Tags to set on the droplet."
  type        = list(string)
  default     = []
}

variable "droplet_graceful_shutdown" {
  description = "Graceful shutdown of the droplet. If set to true, the droplet will be shut down gracefully. Otherwise, it will be terminated."
  type        = bool
  default     = false
}


# Project environment:
variable "environment" {
  description = "Environment to be created."
  type        = string
  default     = "Development"
}

# Firewall variables
variable "firewall_inbound_rules" {
  description = "Inbound firewall rules."
  type = list(object({
    protocol         = string
    port_range       = string
    source_addresses = list(string)
  }))
  default = []
}

variable "firewall_outbound_rule" {
  description = "Outbound firewall rules."
  type = list(object({
    protocol              = string
    port_range            = string
    destination_addresses = list(string)
  }))
  default = []
}


# Block storage variables:
variable "block_storage_size" {
  description = "Size of the block storage to create."
  type        = number
  default     = 0
}

variable "block_storage_filesystem_type" {
  description = "Type of the block storage to create."
  type        = string
  default     = "xfs"
}

variable "block_storage_filesystem_label" {
  description = "Label of the block storage to create."
  type        = string
  default     = "data"
}


variable "reserved_ip" {
  description = "Reserved IP to assign to the droplet."
  type        = bool
  default     = false
}

# load balancer
variable "loadbalancer" {
  description = "Enable load balancer for the droplet."
  type        = bool
  default     = false
}

variable "loadbalancer_name" {
  description = "Name of the load balancer to create."
  type        = string
  default     = ""
}

variable "loadbalancer_size_unit" {
  description = "Size of the load balancer to create."
  type        = number
  default     = 1
}

variable "loadbalancer_algorithm" {
  description = "Algorithm to use for the load balancer."
  type        = string
  default     = "round_robin"
}

variable "loadbalancer_forwarding_rule" {
  description = "List of forwarding_rule maps to apply to the loadbalancer."
  default = {
    entry_protocol  = "http"
    entry_port      = 80
    target_protocol = "http"
    target_port     = 80
    tls_passthrough = false
  }
}

variable "loadbalancer_healthcheck" {
  description = "A healthcheck block to be assigned to the Load Balancer. Only 1 healthcheck is allowed."
  default = {
    protocol                 = "http"
    port                     = 80
    path                     = "/"
    check_interval_seconds   = 10
    response_timeout_seconds = 5
    unhealthy_threshold      = 3
    healthy_threshold        = 5
  }
}
variable "loadbalancer_sticky_sessions" {
  description = "A sticky_sessions block to be assigned to the Load Balancer. Only 1 sticky_sessions block is allowed."
  default = {
    type               = "none"
    cookie_name        = null
    cookie_ttl_seconds = null
  }
}

variable "loadbalancer_redirect_http_to_https" {
  description = "Redirect HTTP to HTTPS for the load balancer."
  type        = bool
  default     = false
}

variable "loadbalancer_enable_proxy_protocol" {
  description = "Enable proxy protocol for the load balancer."
  type        = bool
  default     = false
}

variable "loadbalancer_enable_backend_keepalive" {
  description = "Enable backend keepalive for the load balancer."
  type        = bool
  default     = false
}

variable "loadbalancer_vpc_uuid" {
  description = "VPC UUID to assign the load balancer to."
  type        = string
  default     = ""
}


# Space Variables:
variable "space_name" {
  description = "Name of the space to assign the droplet to."
  type        = list(string)
  default     = []
}

variable "space_region" {
  description = "Region to assign the space to."
  type        = list(string)
  default     = []
}

variable "space_acl" {
  description = "ACL to assign the space to."
  type        = string
  default     = "private"
}

variable "space_force_destroy" {
  description = "Force destroy the space."
  type        = bool
  default     = false
}

# Project Variables:
variable "project_name" {
  description = "Name of the project to assign the droplet to."
  type        = string
  default     = ""
}

variable "project_purpose" {
  description = "Purpose of the project to assign the droplet to."
  type        = string
  default     = "Web Application"
}
