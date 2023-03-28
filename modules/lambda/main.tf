
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


# config lambda function policy
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

# config lambda function policy attachment
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
