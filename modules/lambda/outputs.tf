# Description: Outputs for the lambda module
output "lambda_function_arns" {
  value = [for fn in var.lambda_functions : aws_lambda_function[fn].arn]
}
