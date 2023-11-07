data "google_compute_zones" "available" {
  status = "UP"
}

locals {
  zones = try(data.google_compute_zones.available.names, ["a", "b", "c"])
}

module "instances" {
  source       = "./modules/instances"
  project      = var.project
  name         = var.name
  machine_type = var.machine_type
  zones        = local.zones
  server_count = var.server_count
  image        = var.image
  labels       = var.labels
  boot_disk_params = {
    size = var.boot_disk_params.size
    type = var.boot_disk_params.type
  }
  network            = var.network
  subnetwork         = var.subnetwork
  subnetwork_project = var.subnetwork_project
  region             = var.region
}
