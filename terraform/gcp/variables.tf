variable "project" {
  description = "Name of GCP project that will be used for housing require infrastructure"
  type        = string
}

variable "name" {
  description = "Name of provisioned resource"
  type        = string
  default     = "puppetlabs-provision"
}

variable "machine_type" {
  description = "Machine type to use for the instance"
  type        = string
  default     = "e2-micro"
}

variable "region" {
  description = "GCP region that'll be targeted for infrastructure deployment"
  type        = string
  default     = "us-west1"
}

variable "server_count" {
  description = "Number of servers to deploy"
  type        = number
  default     = 1
}

variable "image" {
  description = "GCP Image to be used for the instance"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "boot_disk_params" {
  description = "Boot disk device configuration"
  type        = map(any)
  default = {
    size = 10
    type = "pd-ssd"
  }
  validation {
    condition     = var.boot_disk_params.size >= 10
    error_message = "Minium disk size for any OS is 10 GB."
  }
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

variable "labels" {
  description = "A list of labels that will be applied to virtual instances"
  type        = map(any)
  default     = {}
}
