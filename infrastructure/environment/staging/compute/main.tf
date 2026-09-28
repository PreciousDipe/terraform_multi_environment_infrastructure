terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" { region = var.region }

locals {
  common_tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
    Project     = "multi-env-assignment"
    Layer       = "compute"
  }
}

data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = var.state_bucket
    key    = "${var.environment}/networking/terraform.tfstate"
    region = var.region
  }
}

module "compute" {
  source                = "../../../modules/compute"
  environment           = var.environment
  vpc_id                = data.terraform_remote_state.networking.outputs.vpc_id
  subnet_ids            = values(data.terraform_remote_state.networking.outputs.private_subnet_ids)
  instance_type         = var.instance_type
  ami_id                = var.ami_id
  min_size              = var.min_size
  max_size              = var.max_size
  desired_capacity      = var.desired_capacity
  allowed_ingress_cidrs = var.allowed_ingress_cidrs
  tags                  = local.common_tags
}