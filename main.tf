provider "google" {
  project = "${var.flynn_gce_project}"
  region  = "${var.flynn_gce_region}"
}

resource "google_compute_instance" "flynn" {
  name         = "${format("${var.flynn_cluster_name}-flynn-%02d", count.index)}"
  machine_type = "${var.flynn_gce_machine_type}"
  zone         = "${var.flynn_gce_region}"
  count        = "${var.flynn_node_count}"
  tags         = ["flynn-${var.flynn_cluster_name}-node"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

  metadata_startup_script = "sudo bash < <(curl -fsSL https://dl.flynn.io/install-flynn)"
}

resource "google_compute_firewall" "flynn" {
  name    = "${var.flynn_cluster_name}-firewall"
  network = "${var.flynn_network}"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "3000-3500"]
  }

  target_tags = ["flynn-${var.flynn_cluster_name}-node"]
}
