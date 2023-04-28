output "log_group_names" {
  value = [for log_group in aws_cloudwatch_log_group.this : log_group.name]
}

output "log_group_arns" {
  value = [for log_group in aws_cloudwatch_log_group.this : log_group.arn]
}
