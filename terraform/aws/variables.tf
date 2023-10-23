variable "region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "us-east-1" 
}

variable "name" {
  description = "Name of provisioned resource"
  type        = string
  default     = "puppetlabs-provision"
}

variable "tags" {
  description = "A map of tags to apply to provisioned resources"
  type        = map
  default     = {}
}

variable "image" {
  description = "AMI to use for the instance"
  type        = string
  default     = ""
}

# variable "vpc_id" {
#   description = "VPC ID to deploy to"
#   type        = string
#   default     = ""
# }

variable "security_group_ids" {
  description = "List of security group IDs to apply to the instance"
  type        = list
  default     = []
}

variable "subnet_id" {
  description = "Subnet ID to provision VM"
  type        = string
  default     = ""
}

variable "root_block_device" {
  description = "Root block device configuration"
  type        = map
  default     = {
    volume_size = 10
    volume_type = "gp3"
  }
}

variable "user" {
  description = "User to create on the instance"
  type        = string
  default     = "centos"
}

variable "ssh_key" {
  description = "SSH key to use for the instance"
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
