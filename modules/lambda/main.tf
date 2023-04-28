
locals {
  lambdas = {
    for name in var.lambda_names : name => {
      name        = name
      source_dir  = "${path.module}/../../dist/${name}"
      output_path = "${path.module}/../../build/${name}.zip"
    }
  }
}

data "archive_file" "lambda_zip" {
  for_each    = local.lambdas
  type        = "zip"
  source_dir  = each.value.source_dir
  output_path = each.value.output_path
  # for_each    = var.lambda_names
  # type        = "zip"
  # source_dir  = "${path.module}/../../dist/${each.value.name}"
  # output_path = "${path.module}/../../build/${each.value.name}.zip"
}

resource "aws_s3_bucket_object" "slz-lambda-fns-zip" {
  for_each     = local.lambdas
  bucket       = var.lambda_bucket_id
  key          = "${each.value.name}.zip"
  source       = data.archive_file.lambda_zip[each.key].output_path
  etag         = filemd5(data.archive_file.lambda_zip[each.key].output_path)
  content_type = "application/zip"
  depends_on = [
    data.archive_file.lambda_zip
  ]
  # for_each     = var.lambdas
  # bucket       = var.lambda_bucket_id
  # key          = "${each.value.name}.zip"
  # source       = data.archive_file.lambda_zip[each.key].output_path
  # etag         = filemd5(data.archive_file.lambda_zip[each.key].output_path)
  # content_type = "application/zip"
  # depends_on = [
  #   data.archive_file.lambda_zip
  # ]
}

resource "aws_lambda_function" "this" {
  for_each         = local.lambdas
  filename         = data.archive_file.lambda_zip[each.key].output_path
  function_name    = each.value.name
  description      = "${each.value.name} Lambda Function"
  handler          = "index.handler"
  runtime          = var.LAMBDA_RUNTIME
  source_code_hash = data.archive_file.lambda_zip[each.key].output_base64sha256
  role             = var.role_arn
  timeout          = 300
  memory_size      = 128
  publish          = true
  depends_on = [
    aws_s3_bucket_object.slz-lambda-fns-zip
  ]
  # for_each         = var.lambdas
  # filename         = data.archive_file.lambda_zip[each.key].output_path
  # function_name    = each.value.name
  # description      = "${each.value.name} Lambda Function"
  # handler          = "index.handler"
  # runtime          = var.LAMBDA_RUNTIME
  # source_code_hash = data.archive_file.lambda_zip[each.key].output_base64sha256
  # role             = var.role_arn
  # timeout          = 300
  # memory_size      = 128
  # publish          = true
  # depends_on = [
  #   aws_s3_bucket_object.slz-lambda-fns-zip
  # ]
}

# module "cloudwatch" {
#   source         = "../cloudwatch"
#   function_name  = aws_lambda_function.this.function_name
#   AWS_REGION     = var.AWS_REGION
#   AWS_ACCOUNT_ID = var.AWS_ACCOUNT_ID
#   depends_on = [
#     aws_lambda_function.this
#   ]
# }

# module "api_gateway" {
#   source        = "../apigateway"
#   function_name = aws_lambda_function.this.function_name
#   description   = "${var.function_name} API Gateway"
#   # resource_path = "/api/others"
#   uri            = aws_lambda_function.this.invoke_arn
#   AWS_REGION     = var.AWS_REGION
#   AWS_ACCOUNT_ID = var.AWS_ACCOUNT_ID
#   depends_on = [
#     aws_lambda_function.this
#   ]
# }
