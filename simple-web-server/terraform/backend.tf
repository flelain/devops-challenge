terraform {
  backend "gcs" {
    bucket = "devops-challenge"
    prefix = "terraform-states"
  }
}