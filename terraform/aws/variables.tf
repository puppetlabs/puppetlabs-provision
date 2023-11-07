variable "region" {
  description = "AWS region to deploy to"
  type        = string
}

variable "name" {
  description = "Name of provisioned resource"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to provisioned resources"
  type        = map(any)
  default     = {}
}

variable "image" {
  description = "AMI to use for the instance"
  type        = string
  default     = "764336703387/AlmaLinux OS 8.8.2023*"
}

variable "image_owner" {
  description = "Owner of the AMI to use for the instance"
  type        = string
  default     = "*"
}

variable "security_group_ids" {
  description = "List of security group IDs to apply to the instance"
  type        = list(any)
  default     = []
}

variable "subnet_id" {
  description = "Subnet ID to provision VM"
  type        = string
  default     = ""
}

variable "root_block_device_volume_size" {
  description = "Root block device size in GB"
  type        = number
  default     = 10
}

variable "root_block_device_volume_type" {
  description = "Root block device type"
  type        = string
  default     = "gp3"
}

variable "ssh_key_name" {
  description = "The name of SSH key to be used to SSH the provisioned node(s)"
  type        = string
  default     = ""
}

variable "instance_size" {
  description = "Instance size to use for the instance"
  type        = string
  default     = "micro"
}

variable "node_count" {
  description = "Number of servers to deploy"
  type        = number
  default     = 1
}

variable "hardware_architecture" {
  description = "Architecture of the AMI to use for the instance"
  type        = string
  default     = "amd"
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

variable "pe_server" {
  description = "The PE server to be used for pointing the VM's puppet agent to"
  type = string
  default = ""
}

variable "os_type" {
  description = "The type of operating system (linux or windows) to be used for provisioning the VMs"
  type = string
  default = "linux"
}

variable "environment" {
  description = "The puppet environment to place the agent in"
  type = string
  default = "production"
}
