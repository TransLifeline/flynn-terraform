variable "flynn_gce_machine_type" {
  default     = "n1-standard-1"
  description = "GCE machine type"
}

variable "flynn_gce_project" {
  description = "GCE project to house cluster"
}

variable "flynn_gce_zone" {
  default     = "us-west1-c"
  description = "Zone to house this cluster"
}

variable "flynn_network" {
  default     = "default"
  description = "GCE network to house this cluster"
}

variable "flynn_node_count" {
  default     = 3
  description = "Number of nodes in the cluster - minimum 3"
}

variable "gce_dns_name" {
  description = "The name of your managed zone in Google DNS"
}

variable "gce_dns_zone" {
  description = "The zone that will house this cluster"
}

variable "gce_ssh_user" {
  description = "The SSH user that will login at the remote machine"
}
