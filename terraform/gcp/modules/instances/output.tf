# Output the public and private IP addresses of the created instance
output "private_ips" {
  value = [
    for instance in google_compute_instance.gcp-server :
    instance.network_interface[0].network_ip
  ]
  description = "The public IPs address of the provisioned node(s)"
}

output "public_ips" {
  value = [
    for instance in google_compute_instance.gcp-server :
    instance.network_interface[0].access_config[0].nat_ip
  ]
  description = "The public IPs address of the provisioned node(s)"
}
