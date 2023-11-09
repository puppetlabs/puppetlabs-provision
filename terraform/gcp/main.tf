provider "google" {
  project = var.project
  region  = var.region
  credentials = var.profile
}

provider "hiera5" {
  scope = {
    hardware_architecture = var.hardware_architecture
  }
}

data "hiera5" "instance_type" {
  key = "instance_type::${var.instance_size}"
}

module "instances" {
  source       = "./modules/instances"
  project      = var.project
  name         = var.name
  machine_type = data.hiera5.instance_type.value
  server_count = var.node_count
  image        = var.image
  labels       = var.tags
  boot_disk_params = {
    size = var.root_block_device_volume_size
    type = var.root_block_device_volume_type
  }
  network            = var.network
  subnetwork         = var.subnetwork
  subnetwork_project = var.subnetwork_project
  region             = var.region
}
