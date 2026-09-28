variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "app_security_group_id" {
  description = "Security group ID of the app tier, allowed to reach the DB"
  type        = string
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "postgres"
  validation {
    condition     = contains(["postgres", "mysql"], var.engine)
    error_message = "engine must be postgres or mysql."
  }
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  validation {
    condition     = can(regex("^db\\.", var.instance_class))
    error_message = "instance_class must start with 'db.', e.g. db.t3.micro."
  }
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  validation {
    condition     = var.allocated_storage >= 20
    error_message = "allocated_storage must be at least 20 GB."
  }
}

variable "multi_az" {
  description = "Whether to deploy a Multi-AZ standby (true for staging/prod)"
  type        = bool
  default     = false
}

variable "db_name" {
  description = "Initial database name"
  type        = string
}

variable "db_port" {
  description = "Port the database listens on (5432 for postgres, 3306 for mysql)"
  type        = number
  default     = 5432
  validation {
    condition     = var.db_port >= 1150 && var.db_port <= 65535
    error_message = "db_port must be between 1150 and 65535."
  }
}

variable "db_username" {
  description = "Master username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Master password (pass via TF_VAR_db_password / secrets manager, never in tfvars)"
  type        = string
  sensitive   = true
}

variable "backup_retention_days" {
  description = "Automated backup retention in days"
  type        = number
  default     = 7
}

variable "deletion_protection" {
  description = "Protect the DB instance from accidental deletion (enable in prod)"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip the final snapshot on destroy (set to false in prod)"
  type        = bool
  default     = true
}

variable "egress_cidr_blocks" {
  description = "CIDR blocks the DB security group may reach on egress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Common tags applied to every resource in this module"
  type        = map(string)
  default     = {}
}