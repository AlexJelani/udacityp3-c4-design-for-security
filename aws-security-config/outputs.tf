
output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.compute.instance_public_ip
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.security.security_group_id
}

output "nacl_id" {
  description = "ID of the Network ACL"
  value       = module.security.nacl_id
}
