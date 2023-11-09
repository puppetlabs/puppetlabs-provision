variable "user" {
  description = "Instance user name that will used for SSH operations"
  type        = string
  default     = "puppet"
}

variable "windows_user" {
  description = "Instance user name that will used for WINRM operations"
  type        = string
  default     = "puppet"
}
variable "windows_password" {
  description = "Password to be used for instance WINRM access"
  type        = string
  sensitive   = true
}

variable "server_count" {
  description = "The quantity of nodes that are deployed within the environment for testing"
  type        = number
}

variable "subnet_id" {
  description = "List of subnet ID provisioned by the networking submodule"
  type        = string
}

variable "resource_group_name" {
  description = "Name of resource group to contain resources"
  type        = string
}

variable "image" {
  description = "The custom image ID to use for deploying new cloud instances"
  default     = "/subscriptions/189c24f8-a365-450a-a074-d06cc6c9e3bb/resourceGroups/app-grp/providers/Microsoft.Compute/galleries/ubuntu_gallery/images/ubuntu/versions/0.0.1"
}

variable "windows_image" {
  description = "The custom image ID to use for deploying new cloud instances"
  default     = ""
}

variable "windows_server_count" {
  description = "The quantity of windows nodes that are deployed within the environment for testing"
  type        = number
  default     = 0
}

variable "tags" {
  description = "A set of tags that will be assigned to resources along with required"
  type        = map
  default     = {}
}

variable "region" {
  description = "Region to create instances in"
  type        = string
}

variable "domain_name" {
  description = "Custom domain to use for internalDNS"
  type        = string
}
