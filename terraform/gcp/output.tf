output "public_ip" {
  value       = module.instances.public_ips
  description = "The public IPs address of the provisioned node(s)"
}

output "private_ip" {
  value       = module.instances.private_ips
  description = "The private IPs address of the provisioned node(s)"
}
