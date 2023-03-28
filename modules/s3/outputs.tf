# Description: Outputs for S3 module
output "s3_bucket_name" {
  value = aws_s3_bucket.slz-lambda-functions.bucket
}
