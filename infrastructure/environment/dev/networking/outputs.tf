output "vpc_id" {
  description = "ID of the VPC"
  value       = module.networking.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.networking.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "Map of AZ to public subnet ID"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Map of AZ to private subnet ID"
  value       = module.networking.private_subnet_ids
}