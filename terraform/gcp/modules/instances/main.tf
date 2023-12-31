data "google_compute_zones" "available" {
  status = "UP"
}

locals {
  zones          = try(data.google_compute_zones.available.names, ["a", "b", "c"])
  file_extension = var.os_type == "windows" ? "ps1" : "sh"
}
resource "google_compute_instance" "gcp-server" {
  name         = "${var.name}-${count.index}"
  machine_type = var.machine_type
  zone         = element(local.zones, count.index)
  count        = var.server_count
  labels       = var.labels

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.boot_disk_params.size
      type  = var.boot_disk_params.type
    }
  }

  network_interface {
    network            = var.network
    subnetwork         = var.subnetwork
    subnetwork_project = var.subnetwork_project
    access_config {}
  }

  metadata_startup_script = templatefile("${path.module}/../../../../scripts/${var.os_type}.${local.file_extension}", {
    pe_server   = var.pe_server,
    environment = var.environment,
    hostname    = var.name
  })
}
