data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../../dist/${var.function_name}"
  output_path = "${path.module}/../../build/${var.function_name}.zip"
}

resource "aws_s3_bucket_object" "slz-lambda-fns-zip" {
  bucket       = var.lambda_bucket_id
  key          = "${var.function_name}.zip"
  source       = data.archive_file.lambda_zip.output_path
  etag         = filemd5(data.archive_file.lambda_zip.output_path)
  content_type = "application/zip"
  depends_on = [
    data.archive_file.lambda_zip
  ]
}

resource "aws_lambda_function" "this" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = var.function_name
  description      = var.description
  handler          = "index.handler"
  runtime          = var.LAMBDA_RUNTIME
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  role             = var.role_arn
  timeout          = 300
  memory_size      = 128
  publish          = true
  depends_on = [
    aws_s3_bucket_object.slz-lambda-fns-zip
  ]
}

