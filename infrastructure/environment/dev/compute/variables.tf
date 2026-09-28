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
  default     = "yourname-tf-state-multi-env"
}

variable "instance_type" {
  description = "EC2 instance type for the app tier"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to launch app instances from"
  type        = string
}

variable "min_size" {
  description = "Minimum ASG size"
  type        = number
}

variable "max_size" {
  description = "Maximum ASG size"
  type        = number
}

variable "desired_capacity" {
  description = "Desired ASG size"
  type        = number
}

variable "allowed_ingress_cidrs" {
  description = "CIDR blocks allowed to reach app instances"
  type        = list(string)
}