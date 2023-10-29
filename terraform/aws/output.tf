output "public_ip" {
  value       = module.instances.public_ips
  description = "The public IPs address of the provisioned node(s)"
}

output "private_dns" {
  value       = module.instances.private_dns
  description = "The private DNS of the provisioned node(s)"
}

output "private_ips" {
  value       = module.instances.private_ips
  description = "The private IPs address of the provisioned node(s)"
}