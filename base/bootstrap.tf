resource "null_resource" "flynn_bootstrap" {
  connection {
    host = "${google_compute_instance.flynn.0.network_interface.0.access_config.0.assigned_nat_ip}"
    user = "${var.gce_ssh_user}"
  }

  provisioner "file" {
    source      = "script/bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "/tmp/bootstrap.sh ${local.flynn_cluster_name}.${var.gce_dns_name} ${flynn_discovery_token.flynn_token.id}",
    ]
  }
}
