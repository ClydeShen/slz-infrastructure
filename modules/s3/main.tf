# config s3 bucket
resource "aws_s3_bucket" "slz-lambda-functions" {
  bucket = "slz-lambda-functions"
  acl    = "private"
}

# # config s3 bucket object
resource "aws_s3_bucket_object" "slz-lambda-fns-zip" {
  bucket = aws_s3_bucket.slz-lambda-functions.id
  key    = var.lambda_zip_file
  source = var.lambda_zip_file
}
