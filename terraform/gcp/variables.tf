variable "user" {
  description = "Instance user name that will used for SSH operations"
  type        = string
}

variable "ssh_key" {
  description = "Location on disk of the SSH public key to be used for instance SSH access"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "region" {
  description = "GCP region that'll be targeted for infrastructure deployment"
  type        = string
  default     = "us-west1"
}

variable "node_count" {
  description = "The quantity of nodes that are deployed within the environment for testing"
  type        = number
  default     = 1
}

variable "image" {
  description = "The disk image to use when deploying new cloud instances"
  type        = string
  default     = ""
}

variable "firewall_allow" {
  description = "List of permitted IP subnets, list most include the internal network and single addresses must be passed as a /32"
  type        = list(string)
  default     = []
}

variable "subnet" {
  description = "An optional subnet to use"
  type        = string
  default     = null
}