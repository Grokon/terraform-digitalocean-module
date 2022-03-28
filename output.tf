output "droplets" {
  description = "Information about the created droplets."
  value = [
    for droplet in digitalocean_droplet.droplet :
    tomap({
      id            = droplet.id,
      name          = droplet.name,
      ipv4_address  = droplet.ipv4_address,
      price_monthly = droplet.price_monthly
    })
  ]
}

output "loadbalancer" {
  description = "Information about the created load balancer."
  value = [
    for loadbalancer in digitalocean_loadbalancer.loadbalancer :
    tomap({
      id            = loadbalancer.id,
      ip            = loadbalancer.ip,
      price_monthly = 10 * var.droplet_count * length(digitalocean_loadbalancer.loadbalancer)
    })
  ]
}

output "volumes" {
  description = "Information about the created volumes."
  value = [
    for volume in digitalocean_volume.volume :
    tomap({
      id            = volume.id,
      name          = volume.name,
      size          = volume.size,
      price_monthly = 0.10 * var.droplet_count * length(digitalocean_volume.volume)
    })
  ]
}

output "spaces" {
  description = "Information about the created spaces."
  value = [
    for space in digitalocean_spaces_bucket.space :
    tomap({
      name               = space.name,
      region             = space.region,
      bucket_domain_name = space.bucket_domain_name
    })
  ]
}

output "firewalls" {
  # count = var.droplet_count
  description = "Information about the created firewalls."
  value       = digitalocean_firewall.firewall

}


output "price_monthly" {
  description = "Mothly cost."
  value       = digitalocean_droplet.droplet[0].price_monthly * var.droplet_count + 0.10 * var.droplet_count * length(digitalocean_volume.volume) + 10 * var.droplet_count * length(digitalocean_loadbalancer.loadbalancer)
}
