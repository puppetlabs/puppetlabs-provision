# Output the public IP address of the created instance
output "public_ips" {
  value = {
    for idx, instance in aws_instance.server :
    idx => instance.public_ip
  }
  description = "The public IPs address of the provisioned node(s)"
}

output "private_dns" {
  value = {
    for idx, instance in aws_instance.server :
    idx => instance.private_dns
  }
  description = "The private DNS of the provisioned node(s)"
}

output "private_ips" {
  value = {
    for idx, instance in aws_instance.server :
    idx => instance.private_ip
  }
  description = "The private IPs of the provisioned node(s)"
}
