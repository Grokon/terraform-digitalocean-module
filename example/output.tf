output "droplets_info" {
  description = "Information about the created droplets."
  value       = module.do-droplet.droplets
}

output "volumes_info" {
  description = "Information about the created volumes."
  value       = module.do-droplet.volumes
}

output "loadbalancer_info" {
  description = "Information about the created load balancer."
  value       = module.do-droplet.loadbalancer
}

output "spaces_info" {
  description = "Information about the created spaces."
  value       = module.do-droplet.spaces
}

output "firewalls_info" {
  description = "Information about the created firewalls."
  value       = module.do-droplet.firewalls
}

output "full_price_monthly" {
  description = "Monthly cost."
  value       = module.do-droplet.price_monthly
}
