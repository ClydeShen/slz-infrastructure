output "s3" {
  value = {
    name = module.s3.s3_bucket_id
  }
}

output "lambda" {
  value = module.lambda.lambda_functions
}

output "cloudwatch" {
  value = {
    log_group_name = module.cloudwatch.log_group_names
    log_group_arn  = module.cloudwatch.log_group_arns
  }
}

output "apigateways" {
  value = module.apigateway.apis
}
