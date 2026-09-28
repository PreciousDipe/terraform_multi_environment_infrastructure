variable "region" {
  type        = string
  description = "The AWS region where the backend resources will be created."
  default     = "us-east-1"
}

variable "state_bucket_name" {
  type        = string
  description = "The globally unique name for your Terraform remote state S3 bucket."
  default     = "terraform-platform-state-bucket-all-environment"
}

variable "lock_table_name" {
  type        = string
  description = "The name of the DynamoDB table used for Terraform state locking."
  default     = "terraform-platform-state-lock"
}