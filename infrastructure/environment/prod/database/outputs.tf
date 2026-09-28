output "db_endpoint" {
  description = "RDS connection endpoint"
  value       = module.database.db_endpoint
}

output "db_identifier" {
  description = "RDS instance identifier"
  value       = module.database.db_identifier
}

output "db_security_group_id" {
  description = "Security group ID attached to the DB"
  value       = module.database.db_security_group_id
}