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
    Layer       = "database"
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

data "terraform_remote_state" "compute" {
  backend = "s3"
  config = {
    bucket = var.state_bucket
    key    = "${var.environment}/compute/terraform.tfstate"
    region = var.region
  }
}

module "database" {
  source                = "../../../modules/database"
  environment           = var.environment
  vpc_id                = data.terraform_remote_state.networking.outputs.vpc_id
  private_subnet_ids    = values(data.terraform_remote_state.networking.outputs.private_subnet_ids)
  app_security_group_id = data.terraform_remote_state.compute.outputs.security_group_id
  engine_version        = var.db_engine_version
  instance_class        = var.db_instance_class
  allocated_storage     = var.db_allocated_storage
  multi_az              = var.db_multi_az
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  tags                  = local.common_tags
}