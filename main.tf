# module for s3
module "s3" {
  source = "./modules/s3"
}

# module for iam
module "iam" {
  source = "./modules/iam"
}

module "openai" {
  source           = "./modules/lambda"
  function_name    = "openai"
  description      = "Lambda Function for OpenAI"
  role_arn         = module.iam.lambda_role_arn
  lambda_bucket_id = module.s3.s3_bucket_id
}

module "others" {
  source           = "./modules/lambda"
  function_name    = "others"
  description      = "Lambda Function for OpenAI"
  role_arn         = module.iam.lambda_role_arn
  lambda_bucket_id = module.s3.s3_bucket_id
}
