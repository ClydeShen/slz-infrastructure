locals {
  folder_path  = "dist"
  lambda_names = [for f in fileset(local.folder_path, "/*/index.js") : dirname(f)]
}

module "s3" {
  source = "./modules/s3"
}

module "iam" {
  source = "./modules/iam"
}

module "lambda" {
  source           = "./modules/lambda"
  lambda_names     = local.lambda_names
  role_arn         = module.iam.lambda_role_arn
  lambda_bucket_id = module.s3.s3_bucket_id
  # AWS_REGION       = var.AWS_REGION
  # AWS_ACCOUNT_ID   = var.AWS_ACCOUNT_ID
}

module "cloudwatch" {
  source           = "./modules/cloudwatch"
  lambda_functions = module.lambda.lambda_functions
  AWS_REGION       = var.AWS_REGION
  AWS_ACCOUNT_ID   = var.AWS_ACCOUNT_ID
  depends_on = [
    module.lambda
  ]
}

module "apigateway" {
  source           = "./modules/apigateway"
  lambda_functions = module.lambda.lambda_functions
  AWS_REGION       = var.AWS_REGION
  AWS_ACCOUNT_ID   = var.AWS_ACCOUNT_ID
  depends_on = [
    module.lambda
  ]
}

# module "openai" {
#   source           = "./modules/lambda"
#   function_name    = "openai"
#   description      = "Lambda Function for OpenAI"
#   role_arn         = module.iam.lambda_role_arn
#   lambda_bucket_id = module.s3.s3_bucket_id
#   AWS_REGION       = var.AWS_REGION
#   AWS_ACCOUNT_ID   = var.AWS_ACCOUNT_ID
# }

# module "others" {
#   source           = "./modules/lambda"
#   function_name    = "others"
#   description      = "Lambda Function for OpenAI"
#   role_arn         = module.iam.lambda_role_arn
#   lambda_bucket_id = module.s3.s3_bucket_id
#   AWS_REGION       = var.AWS_REGION
#   AWS_ACCOUNT_ID   = var.AWS_ACCOUNT_ID
# }
