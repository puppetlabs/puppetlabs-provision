variable "user" {
  description = "Instance user name that will used for SSH operations"
  type        = string
}

variable "windows_user" {
  description = "Instance user name that will used for WINRM operations"
  type        = string
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

variable "id" {
  description = "Randomly generated value used to produce unique names for everything to prevent collisions and visually link resources together"
  type        = string
}

variable "subnet_id" {
  description = "List of subnet ID provisioned by the networking submodule"
  type        = string
}

variable "resource_group" {
  description = "Name of resource group to contain resources"
}

variable "image" {
  description = "The custom image ID to use for deploying new cloud instances"
}

variable "windows_image" {
  description = "The custom image ID to use for deploying new cloud instances"
}

variable "windows_server_count" {
  description = "The quantity of windows nodes that are deployed within the environment for testing"
  type        = number
}

variable "tags" {
  description = "A set of tags that will be assigned to resources along with required"
  type        = map
}

variable "region" {
  description = "Region to create instances in"
  type        = string
}

variable "domain_name" {
  description = "Custom domain to use for internalDNS"
  type        = string
}
