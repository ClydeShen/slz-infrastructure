# setup cloudwatch
resource "aws_cloudwatch_log_group" "this" {
  for_each          = var.lambda_functions
  name              = "/aws/lambda/${each.key}"
  retention_in_days = 30

}
# allow cloudwatch logs
resource "aws_lambda_permission" "allow_cloudwatch_logs" {
  for_each      = var.lambda_functions
  action        = "lambda:InvokeFunction"
  function_name = each.key
  principal     = "logs.${var.AWS_REGION}.amazonaws.com"
  source_arn    = "${aws_cloudwatch_log_group.this[each.key].arn}:*"
}
