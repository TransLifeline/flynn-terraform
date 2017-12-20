terraform {
  backend "gcs" {
    bucket = "flynn-terraform-state"
    prefix = "test-cluster"
  }

  required_version = "= 0.11.1"
}
