variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "state_bucket" {
  description = "S3 bucket holding the Terraform state files (used to read upstream layers)"
  type        = string
  default     = "terraform-platform-state-bucket-all-environment"
}

variable "db_engine_version" {
  description = "RDS engine version"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "db_allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
}

variable "db_multi_az" {
  description = "Whether RDS deploys a Multi-AZ standby"
  type        = bool
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "platformdb"
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "RDS master password. Supply via TF_VAR_db_password, never in tfvars"
  type        = string
  sensitive   = true
}