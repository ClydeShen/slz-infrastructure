output "lambda_functions" {
  value = {
    for lambda in aws_lambda_function.this : lambda.function_name => {
      name       = lambda.function_name
      arn        = lambda.arn
      invoke_arn = lambda.invoke_arn
    }
  }
}
