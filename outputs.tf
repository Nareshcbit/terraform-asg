output "launch_config_id" { value = aws_launch_configuration.this.id}
output "launch_config_arn" { value = aws_launch_configuration.this.arn}
output "launch_config_name" { value = aws_launch_configuration.this.name}

output "asg_id" { value = aws_autoscaling_group.this.id}
output "asg_arn" { value = aws_autoscaling_group.this.arn}
output "asg_name" { value = aws_autoscaling_group.this.name}
