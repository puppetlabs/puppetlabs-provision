variable "region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "us-west-2"
}

variable "name" {
  description = "Name of provisioned resource"
  type        = string
  default     = "puppetlabs-provision"
}

variable "tags" {
  description = "A map of tags to apply to provisioned resources"
  type        = map(any)
  default     = {}
}

variable "image" {
  description = "AMI to use for the instance"
  type        = string
  default     = ""
}

variable "image_owner" {
  description = "Owner of the AMI to use for the instance"
  type        = string
  default     = "*"
}

variable "image_architecture" {
  description = "Architecture of the AMI to use for the instance"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to apply to the instance"
  type        = list(any)
  default     = []
}

variable "subnet_id" {
  description = "Subnet ID to provision a VM"
  type        = string
  default     = ""
}

variable "root_block_device" {
  description = "Root block device configuration"
  type        = map(any)
  default = {
    volume_size = 10
    volume_type = "gp3"
  }
}

variable "ssh_key_name" {
  description = "The name of SSH key to be used to SSH the provisioned node(s)"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "Instance type to use for the instance"
  type        = string
  default     = "t3.medium"
}

variable "node_count" {
  description = "Number of servers to deploy"
  type        = number
  default     = 1
}

variable "profile" {
  description = "AWS profile to use"
  type        = string
  default     = "default"
}

variable "associate_public_ip_address" {
  description = "To associate public ip address"
  type        = bool
  default     = false
}
