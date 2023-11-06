# Terraform setup stuff, required providers, where they are sourced from, and
# the provider's configuration requirements.
provider "aws" {
  region  = var.region
  profile = var.profile
  default_tags {
    tags = var.tags
  }
}

provider "hiera5" {
  scope = {
    hardware_architecture = var.hardware_architecture
  }
}

data "hiera5" "instance_type" {
  key = "instance_type::${var.instance_size}"
}

data "hiera5" "image_architecture" {
  key = "image::${var.hardware_architecture}"
}

locals {
  image_metadata = split("/", var.image)
  # get the image name & owner name from provided image value
  image_name                    = try(local.image_metadata[1], local.image_metadata[0])
  image_owner                   = try(local.image_metadata[0], "*")
  root_block_device_volume_size = tonumber(var.root_block_device_volume_size)
}

# Contain all the instances configuration for readability
# 
module "instances" {
  source                      = "./modules/instances"
  name                        = var.name
  instance_type               = data.hiera5.instance_type.value
  subnet_id                   = var.subnet_id
  security_group_ids          = var.security_group_ids
  ssh_key_name                = var.ssh_key_name
  node_count                  = var.node_count
  image                       = local.image_name
  image_owner                 = local.image_owner
  image_architecture          = data.hiera5.image_architecture.value
  associate_public_ip_address = var.associate_public_ip_address
  tags                        = var.tags
  root_block_device = {
    volume_type = var.root_block_device_volume_type
    volume_size = local.root_block_device_volume_size
  }
}
