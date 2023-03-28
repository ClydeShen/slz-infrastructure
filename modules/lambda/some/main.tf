# resource for some lambda function
resource "aws_lambda_function" "some" {
  function_name    = "some"
  description      = "Lambda Function for Some"
  filename         = var.lambda_zip_file_path
  handler          = "some.handler"
  role             = aws_iam_role.lambda_role.arn
  runtime          = var.LAMBDA_RUNTIME
  source_code_hash = filebase64sha256(var.lambda_zip_file_path)
  timeout          = 300
  memory_size      = 128
  publish          = true
  environment {
    variables = {
      "S3_BUCKET" = aws_s3_bucket.slz-lambda-functions.id
    }
  }
}
