variable "project" {
  description = "Name of GCP project that will be used for housing require infrastructure"
  type        = string
}

variable "name" {
  description = "Name of provisioned resource"
  type        = string
}

variable "instance_size" {
  description = "Machine type to use for the instance"
  type        = string
}

variable "region" {
  description = "GCP region that'll be targeted for infrastructure deployment"
  type        = string
}

variable "node_count" {
  description = "Number of servers to deploy"
  type        = number
}

variable "image" {
  description = "GCP Image to be used for the instance"
  type        = string
}

variable "root_block_device_volume_size" {
  description = "Root block device size in GB"
  type        = string
  default     = "10"
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
}

variable "tags" {
  description = "A list of labels that will be applied to virtual instances"
  type        = map(any)
}

variable "hardware_architecture" {
  description = "Hardware architecture of the instance"
  type        = string
  default     = "amd"
}
