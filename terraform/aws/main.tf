# Terraform setup stuff, required providers, where they are sourced from, and
# the provider's configuration requirements.
provider "aws" {
  region = var.region
  profile = var.profile
  default_tags {
    tags = var.tags
  }
}

# Contain all the instances configuration for readability
# 
module "instances" {
  name               = var.name
  source             = "./modules/instances"
  subnet_id          = var.subnet_id
  security_group_ids = var.security_group_ids
  user               = var.user
  ssh_key            = var.ssh_key
  node_count         = var.node_count
  image              = var.image
  tags               = var.tags
}
