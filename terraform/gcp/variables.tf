variable "project" {
  description = "Name of GCP project that will be used for the required infrastructure"
  type        = string
}

variable "name" {
  description = "Name of provisioned resource"
  type        = string
}

variable "instance_size" {
  description = "Machine type to use for the instance"
  type        = string
  default     = "small"
}

variable "region" {
  description = "GCP region that'll be targeted for infrastructure deployment"
  type        = string
}

variable "node_count" {
  description = "Number of instances to provision"
  type        = number
  default     = 1
}

variable "image" {
  description = "GCP Image to be used for the instance"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "root_block_device_volume_size" {
  description = "Root block device size in GB"
  type        = number
  default     = 10
}

variable "root_block_device_volume_type" {
  description = "Root block device type"
  type        = string
  default     = "pd-ssd"
}

variable "network" {
  description = "VPC network provisioned by the networking submodule"
  type        = string
  default     = "default"
}

variable "subnetwork" {
  description = "Regional subnetwork assigned to VPC network provisioned by the networking submodule"
  type        = string
  default     = "default"
}

variable "subnetwork_project" {
  description = "Regional subnetwork project assigned to VPC network provisioned by the networking submodule"
  type        = string
  default     = null
}

variable "tags" {
  description = "A list of labels that will be applied to virtual instances"
  type        = map(any)
  default     = {}
}

variable "hardware_architecture" {
  description = "Hardware architecture of the instance"
  type        = string
  default     = "amd"
}

variable "profile" {
  description = "GCP profile to use"
  type        = string
}

variable "pe_server" {
  description = "The PE server to be used for pointing the VM's puppet agent to"
  type        = string
  default     = ""
}

variable "os_type" {
  description = "The type of operating system (linux or windows) to be used for provisioning the VMs"
  type        = string
  default     = "linux"
}

variable "environment" {
  description = "The puppet environment to place the agent in"
  type        = string
  default     = "production"
}