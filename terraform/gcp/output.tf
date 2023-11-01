# Output data used by Bolt to do further work, doing this allows for a clean and
# abstracted interface between cloud provider implementations
output "public_ip" {
  value       = module.instances.console
  description = "This will by the external IP address assigned to the Puppet Enterprise console"
}
