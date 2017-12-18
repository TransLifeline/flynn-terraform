variable "flynn_cluster_name" {}

variable "flynn_gce_machine_type" {
  default = "n1-standard-1"
}

variable "flynn_gce_project" {
  default = "flynn-staging"
}

variable "flynn_gce_zone" {
  default = "us-west1-c"
}

variable "flynn_network" {
  default = "default"
}

variable "flynn_node_count" {
  default = 3
}

variable "gce_dns_name" {}
variable "gce_dns_zone" {}
variable "gce_ssh_user" {}
