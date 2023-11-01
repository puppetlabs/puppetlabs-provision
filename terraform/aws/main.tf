# Terraform setup stuff, required providers, where they are sourced from, and
# the provider's configuration requirements.
provider "aws" {
  region  = var.region
  profile = var.profile
  default_tags {
    tags = var.tags
  }
}

locals {
  image_metadata = split("/", var.image)
  # get the image name & owner name from provided image value
  image_name  = try(local.image_metadata[1], local.image_metadata[0])
  image_owner = try(local.image_metadata[1], "*")
}

# Contain all the instances configuration for readability
# 
module "instances" {
  name               = var.name
  source             = "./modules/instances"
  subnet_id          = var.subnet_id
  security_group_ids = var.security_group_ids
  ssh_key_name       = var.ssh_key_name
  node_count         = var.node_count
  image              = local.image_name
  image_owner        = local.image_owner
  image_architecture = var.image_architecture
  tags               = var.tags
  root_block_device = {
    volume_type = var.root_block_device.volume_type
    volume_size = var.root_block_device.volume_size
  }
}
