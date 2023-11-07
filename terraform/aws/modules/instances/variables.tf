variable "name" {
  description = "Name of provisioned resource"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to provisioned resources"
  type        = map(any)
}

variable "image" {
  description = "AMI to use for the instance"
  type        = string
}

variable "image_owner" {
  description = "Owner of the AMI to use for the instance"
  type        = string
}

variable "image_architecture" {
  description = "Architecture of the AMI to use for the instance"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to apply to the instance"
  type        = list(any)
}

variable "subnet_id" {
  description = "Subnet ID to provision a VM"
  type        = string
}

variable "root_block_device" {
  description = "Root block device configuration"
  type        = map(any)
}

variable "ssh_key_name" {
  description = "The name of SSH key to be used to SSH the provisioned node(s)"
  type        = string
}

variable "instance_type" {
  description = "Instance type to use for the instance"
  type        = string
}

variable "node_count" {
  description = "Number of servers to deploy"
  type        = number
}

variable "associate_public_ip_address" {
  description = "To associate public ip address"
  type        = bool
}

variable "pe_server" {
  description = "The PE server endpoint to run the puppet agent"
  type = string
}

variable "os_type" {
  description = "The type of OS (windows or linux) to configure the puppet agent using bootstrap script"
  type = string
}

variable "environment" {
  description = "The puppet environment to configure the puppet agent"
  type = string
}
