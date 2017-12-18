provider "google" {
  project = "${var.flynn_gce_project}"
  region  = "${substr(var.flynn_gce_zone,0,length(var.flynn_gce_zone)-2)}"
}

locals {
  flynn_cluster_name = "${basename(path.cwd)}"
}

resource "google_compute_instance" "flynn" {
  name         = "${format("${local.flynn_cluster_name}-flynn-%02d", count.index)}"
  machine_type = "${var.flynn_gce_machine_type}"
  zone         = "${var.flynn_gce_zone}"
  count        = "${var.flynn_node_count}"
  tags         = ["flynn-${local.flynn_cluster_name}-node"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  provisioner "remote-exec" {
    connection {
      user = "${var.gce_ssh_user}"
    }

    inline = [
      "curl -fSsLo /tmp/install-flynn https://dl.flynn.io/install-flynn",
      "sudo bash /tmp/install-flynn | tee install-flynn.log | grep ===",
      "sudo flynn-host init --discovery ${flynn_discovery_token.flynn_token.id}",
      "sudo systemctl start flynn-host",
    ]
  }
}

resource "google_compute_firewall" "flynn" {
  name    = "${local.flynn_cluster_name}-firewall"
  network = "${var.flynn_network}"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "3000-3500"]
  }

  target_tags = ["flynn-${local.flynn_cluster_name}-node"]
}

resource "google_dns_record_set" "flynn-a" {
  name         = "${local.flynn_cluster_name}.${var.gce_dns_name}."
  type         = "A"
  ttl          = 20
  managed_zone = "${var.gce_dns_zone}"
  rrdatas      = ["${google_compute_instance.flynn.*.network_interface.0.access_config.0.assigned_nat_ip}"]
}

resource "google_dns_record_set" "flynn-cname" {
  name         = "*.${local.flynn_cluster_name}.${var.gce_dns_name}."
  type         = "CNAME"
  ttl          = 20
  managed_zone = "${var.gce_dns_zone}"
  rrdatas      = ["${local.flynn_cluster_name}.${var.gce_dns_name}."]
}

resource "flynn_discovery_token" "flynn_token" {}
