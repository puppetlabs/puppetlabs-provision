resource "google_compute_instance" "gcp-server" {
  name         = "${var.name}-${count.index}"
  machine_type = "${var.machine_type}"
  zone         = element(var.zones, count.index)
  count        = var.server_count
  labels = var.labels

  boot_disk {
    initialize_params {
      image = "${var.image}"
      size = var.boot_disk_params.size
      type = "${var.boot_disk_params.type}"
    }
  }

  network_interface {
    network            = var.network
    subnetwork         = var.subnetwork
    subnetwork_project = var.subnetwork_project
    access_config {}
  }
}