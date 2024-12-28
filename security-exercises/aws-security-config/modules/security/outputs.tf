
output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.main.id
}

output "nacl_id" {
  description = "ID of the Network ACL"
  value       = aws_network_acl.main.id
}
