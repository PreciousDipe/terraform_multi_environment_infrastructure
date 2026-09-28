variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "vpc_id" {
  description = "VPC ID to launch instances into"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs the ASG will launch instances into"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  validation {
    condition     = can(regex("^[a-z][0-9][a-z]?\\.(nano|micro|small|medium|large|xlarge|[0-9]+xlarge)$", var.instance_type))
    error_message = "instance_type must look like a valid EC2 type, e.g. t3.micro."
  }
}

variable "ami_id" {
  description = "AMI ID to launch"
  type        = string
  validation {
    condition     = can(regex("^ami-[0-9a-f]{8,17}$", var.ami_id))
    error_message = "ami_id must look like ami-0123456789abcdef0."
  }
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
  description = "CIDR blocks allowed to reach instances on the app port"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "app_port" {
  description = "Application port to open from allowed_ingress_cidrs"
  type        = number
  default     = 80
}

variable "egress_cidr_blocks" {
  description = "CIDR blocks instances are allowed to reach on egress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Common tags applied to every resource in this module"
  type        = map(string)
  default     = {}
}