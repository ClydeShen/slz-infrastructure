# config s3 bucket
resource "aws_s3_bucket" "slz-lambda-functions" {
  bucket = var.s3_bucket
  acl    = "private"
}
