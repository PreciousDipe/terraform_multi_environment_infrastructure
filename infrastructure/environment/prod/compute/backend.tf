terraform {
  backend "s3" {
    bucket         = "terraform-platform-state-bucket-all-environment"
    key            = "dev/compute/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-platform-state-lock"
    encrypt        = true
  }
}