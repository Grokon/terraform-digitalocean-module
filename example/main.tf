module "do" {
  source       = "../"
  droplet_name = "terra-test"
  # environment  = "Development"
  # project_name  = "terra-test"
  # droplet_count = 1

  # block_storage_size = 5

  # loadbalancer      = true
  # loadbalancer_name = "terra-test-lb"

  # space_name   = ["terra-test-space", "terra-test-space2"]
  # space_region = ["nyc3"]

  # firewall_inbound_rules = [
  #   {
  #     protocol         = "tcp"
  #     port_range       = "22"
  #     source_addresses = ["0.0.0.0/0", "::/0"]
  #   },
  #   {
  #     protocol         = "icmp"
  #     port_range       = null
  #     source_addresses = ["0.0.0.0/0", "::/0"]
  #   }
  # ]

}
