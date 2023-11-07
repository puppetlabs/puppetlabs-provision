variable "project" {
  description = "Name of GCP project that will be used for housing require infrastructure"
  type        = string
}

variable "name" {
  description = "Name of provisioned resource"
  type        = string
}

variable "machine_type" {
  description = "Machine type to use for the instance"
  type        = string
}

variable "region" {
  description = "GCP region that'll be targeted for infrastructure deployment"
  type        = string
}

variable "server_count" {
  description = "Number of servers to deploy"
  type        = number
}

variable "image" {
  description = "GCP Image to be used for the instance"
  type        = string
}

variable "boot_disk_params" {
  description = "Boot disk device configuration"
  type        = map(any)
}

variable network    {
  description = "VPC network provisioned by the networking submodule"
  type        = string
}

variable subnetwork {
  description = "Regional subnetwork assigned to VPC network provisioned by the networking submodule"
  type        = string
}

variable subnetwork_project {
  description = "Regional subnetwork project assigned to VPC network provisioned by the networking submodule"
  type        = string
}

variable "labels" {
  description = "A list of labels that will be applied to virtual instances"
  type        = map
}
