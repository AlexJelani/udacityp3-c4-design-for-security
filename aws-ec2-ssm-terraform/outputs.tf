output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.ssm_instance.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.ssm_instance.public_ip
}

output "instance_state" {
  description = "State of the EC2 instance"
  value       = aws_instance.ssm_instance.instance_state
}
