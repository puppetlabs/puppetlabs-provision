output "public_ips" {
  value = azurerm_network_interface.server_nic.*.private_ip_address
}

output "private_ips" {
  value = azurerm_network_interface.server_nic.*.ip_configuration
}