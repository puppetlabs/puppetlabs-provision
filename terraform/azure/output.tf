output "public_ip" {
  value = module.instances.public_ips
  description = "The public IP address of the instance"
}

output "private_ips" {
  value = module.instances.private_ips
  description = "The private IP address of the instance"
}
