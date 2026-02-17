terraform {
  backend "s3" {
    bucket = "arpit-terraform-state-unique-123"
    key    = "strapi/terraform.tfstate"
    region = "us-east-1"
  }
}

