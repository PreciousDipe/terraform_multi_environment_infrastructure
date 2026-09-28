output "security_group_id" {
  description = "ID of the app security group"
  value       = module.compute.security_group_id
}

output "asg_name" {
  description = "Name of the app Auto Scaling Group"
  value       = module.compute.asg_name
}

output "launch_template_id" {
  description = "ID of the launch template"
  value       = module.compute.launch_template_id
}