provider "azurerm" {
  features {}
}

resource "random_id" "deployment" {
  byte_length = 3
}

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.region
  tags     = var.tags
}

module "instances" {
  source                  = "./modules/instances"
  id                      = random_id.deployment.hex
  subnet_id               = var.subnet_id
  user                    = var.user
  server_count            = var.server_count
  windows_server_count    = var.windows_server_count
  tags                    = var.tags
  image                   = var.image
  windows_image           = var.windows_image
  windows_password        = var.windows_password
  windows_user            = var.windows_user
  resource_group          = azurerm_resource_group.resource_group
  region                  = var.region
  domain_name             = var.domain_name
}
