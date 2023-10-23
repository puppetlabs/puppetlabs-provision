# Output the public IP address of the created instance
output "public_ips" {
  value = {
    for idx, instance in aws_instance.server :
    idx => instance.public_ip
  }
  description = "The public IP addresses of the instance"
}

output "private_ips" {
  value = {
    for idx, instance in aws_instance.server :
    idx => instance.private_ip
  }
  description = "The private IP addresses of the instance"
}
