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
      "/tmp/bootstrap.sh ${substr(google_dns_record_set.flynn-a.name,0,length(google_dns_record_set.flynn-a.name)-1)} ${flynn_discovery_token.flynn_token.id}",
    ]
  }
}
