variable "s3_bucket" {
  default     = "slz-lambda-functions"
  description = "Name of the S3 bucket where the Lambda functions are uploaded"
}

variable "lambda_zip_file" {
  default     = "slz-lambda-fns.zip"
  description = "Name of the Lambda zip file"
}

