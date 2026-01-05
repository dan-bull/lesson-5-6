terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "root/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
  }
}