terraform {
  backend "gcs" {
    bucket = "flynn-terraform-state"
    prefix = "other-cluster"
  }

  required_version = "= 0.11.1"
}
