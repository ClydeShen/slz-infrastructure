# resource for openai lambda function
resource "aws_lambda_function" "openai" {
  function_name    = "openai"
  description      = "Lambda Function for OpenAI"
  filename         = var.lambda_zip_file_path
  handler          = "openai.handler"
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
