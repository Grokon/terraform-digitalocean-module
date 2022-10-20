# Get default values of vpc_uuid for chosen region:
data "digitalocean_vpc" "vpc" {
  region = var.region
}

# Get all available ssh keys:
data "digitalocean_ssh_keys" "keys" {}

# Create a droplet:
resource "digitalocean_droplet" "droplet" {
  count = var.droplet_count
  image = var.droplet_image

  # %02d = 1 -> 01, 2 -> 02, etc.
  name   = var.droplet_count == 1 ? var.droplet_name : format("%s-%s", var.droplet_name, format("%02d", count.index + 1))
  region = var.region
  size   = var.droplet_size

  # Optional
  backups           = var.droplet_backups
  monitoring        = var.droplet_monitoring
  ipv6              = var.droplet_ipv6
  vpc_uuid          = var.droplet_vpc_uuid != "" ? var.droplet_vpc_uuid : data.digitalocean_vpc.vpc.id
  ssh_keys          = length(var.droplet_ssh_keys) > 0 ? var.droplet_ssh_keys : data.digitalocean_ssh_keys.keys.ssh_keys.*.id
  resize_disk       = var.droplet_resize_disk
  tags              = length(var.droplet_tags) > 0 ? var.droplet_tags : compact([var.project_name, var.environment, var.region])
  graceful_shutdown = var.droplet_graceful_shutdown
}


# Create a droplet firewall:
resource "digitalocean_firewall" "firewall" {
  count       = length(var.firewall_inbound_rules) > 0 || length(var.firewall_outbound_rule) > 0 ? 1 : 0
  name        = format("%s-%s", "firewall", coalesce(var.project_name, var.droplet_name))
  droplet_ids = digitalocean_droplet.droplet.*.id
  dynamic "inbound_rule" {
    for_each = var.firewall_inbound_rules
    content {
      protocol         = inbound_rule.value["protocol"]
      port_range       = inbound_rule.value["port_range"]
      source_addresses = inbound_rule.value["source_addresses"]
    }
  }
  dynamic "outbound_rule" {
    for_each = var.firewall_outbound_rule
    content {
      protocol              = outbound_rule.value["protocol"]
      port_range            = outbound_rule.value["port_range"]
      destination_addresses = outbound_rule.value["destination_addresses"]
    }
  }
}


# Create block storage volume:
resource "digitalocean_volume" "volume" {
  count  = var.block_storage_size > 0 ? var.droplet_count : 0
  region = var.region
  name   = format("%s-%s", "volume", element(digitalocean_droplet.droplet.*.name, count.index))
  size   = var.block_storage_size
  # Optional
  description              = "Block storage for ${element(digitalocean_droplet.droplet.*.name, count.index)}"
  initial_filesystem_type  = var.block_storage_filesystem_type
  initial_filesystem_label = var.block_storage_filesystem_label
}

# Atach volumes to droplets:
resource "digitalocean_volume_attachment" "volume_attachment" {
  count      = var.block_storage_size > 0 ? var.droplet_count : 0
  droplet_id = element(digitalocean_droplet.droplet.*.id, count.index)
  volume_id  = element(digitalocean_volume.volume.*.id, count.index)
}


# Create Reserved IP:
resource "digitalocean_reserved_ip" "reserved_ip" {
  count  = var.reserved_ip == true && var.droplet_count > 0 ? coalesce(var.reserved_ip_count, var.droplet_count) : 0
  region = var.region
}
# Atach reserved IP to droplets:
resource "digitalocean_reserved_ip_assignment" "reserved_ip_assignment" {
  depends_on = [digitalocean_droplet.droplet]
  count      = var.reserved_ip == true && var.reserved_ip_assign == true && var.droplet_count > 0 ? coalesce(var.reserved_ip_count, var.droplet_count) : 0

  ip_address = element(digitalocean_reserved_ip.reserved_ip.*.id, count.index)
  droplet_id = element(digitalocean_droplet.droplet.*.id, count.index)
}


# Create a load balancer:
resource "digitalocean_loadbalancer" "loadbalancer" {
  count = var.loadbalancer == true ? 1 : 0

  name      = coalesce(var.loadbalancer_name, format("%s-load-balancer", var.droplet_name))
  region    = var.region
  size_unit = var.loadbalancer_size_unit
  algorithm = var.loadbalancer_algorithm

  forwarding_rule {
    entry_protocol  = lookup(var.loadbalancer_forwarding_rule, "entry_protocol")
    entry_port      = lookup(var.loadbalancer_forwarding_rule, "entry_port")
    target_protocol = lookup(var.loadbalancer_forwarding_rule, "target_protocol")
    target_port     = lookup(var.loadbalancer_forwarding_rule, "target_port")
    tls_passthrough = lookup(var.loadbalancer_forwarding_rule, "tls_passthrough")
  }
  healthcheck {
    protocol                 = lookup(var.loadbalancer_healthcheck, "protocol")
    port                     = lookup(var.loadbalancer_healthcheck, "port")
    path                     = lookup(var.loadbalancer_healthcheck, "path")
    check_interval_seconds   = lookup(var.loadbalancer_healthcheck, "check_interval_seconds")
    response_timeout_seconds = lookup(var.loadbalancer_healthcheck, "response_timeout_seconds")
    unhealthy_threshold      = lookup(var.loadbalancer_healthcheck, "unhealthy_threshold")
    healthy_threshold        = lookup(var.loadbalancer_healthcheck, "healthy_threshold")
  }
  sticky_sessions {
    type               = lookup(var.loadbalancer_sticky_sessions, "type")
    cookie_name        = lookup(var.loadbalancer_sticky_sessions, "cookie_name")
    cookie_ttl_seconds = lookup(var.loadbalancer_sticky_sessions, "cookie_ttl_seconds")
  }

  redirect_http_to_https   = var.loadbalancer_redirect_http_to_https
  enable_proxy_protocol    = var.loadbalancer_enable_proxy_protocol
  enable_backend_keepalive = var.loadbalancer_enable_backend_keepalive
  vpc_uuid                 = coalesce(var.loadbalancer_vpc_uuid, data.digitalocean_vpc.vpc.id)
  droplet_ids              = digitalocean_droplet.droplet.*.id
}


# Create a space:
resource "digitalocean_spaces_bucket" "space" {
  count         = length(var.space_name)
  name          = element(var.space_name, count.index)
  region        = length(var.space_region) > count.index ? element(var.space_region, count.index) : var.region
  acl           = var.space_acl
  force_destroy = var.space_force_destroy
}


# Create a ptoject:
resource "digitalocean_project" "project" {
  count       = var.project_name != "" ? 1 : 0
  name        = var.project_name
  description = "A project for ${var.project_name}"
  purpose     = var.project_purpose
  environment = var.environment # Development, Staging, Production
}

# Atach resources to project:
resource "digitalocean_project_resources" "project_resource" {
  count     = var.project_name != "" ? 1 : 0
  project   = digitalocean_project.project[count.index].id
  resources = compact(concat(digitalocean_droplet.droplet.*.urn, digitalocean_volume.volume.*.urn, digitalocean_loadbalancer.loadbalancer.*.urn, digitalocean_spaces_bucket.space.*.urn))
}
