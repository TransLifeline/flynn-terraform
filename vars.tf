variable "flynn_cluster_name" {
  default = "test-cluster"
}

variable "flynn_gce_machine_type" {
  default = "n1-standard-1"
}

variable "flynn_gce_project" {
  default = "flynn-staging"
}

variable "flynn_gce_region" {
  default = "us-west1-c"
}

variable "flynn_network" {
  default = "default"
}

variable "flynn_node_count" {
  default = 3
}
