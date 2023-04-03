# module for s3
module "s3" {
  source = "./modules/s3"
}

# import module of lambda
module "lambda" {
  source          = "./modules/lambda"
  LAMBDA_RUNTIME  = var.LAMBDA_RUNTIME
  lambda_zip_file = module.s3.s3_bucket_object_key
  # # pass in the s3 bucket name
  # s3_bucket_name = module.s3.s3_bucket_name
  # # pass in the s3 bucket object key
  # s3_bucket_object_key = aws_s3_bucket_object.slz-lambda-fns-zip.key
  # # pass in the s3 bucket object version id
  # s3_bucket_object_version_id = aws_s3_bucket_object.slz-lambda-fns-zip.version_id
  # # pass in the lambda zip file path
  # lambda_zip_file_path = var.lambda_zip_file_path
  # # pass in the lambda functions
  # lambda_functions = var.lambda_functions
}


