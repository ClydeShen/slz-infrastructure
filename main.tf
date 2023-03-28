# import module of lambda
module "lambda" {
  source = "./modules/lambda"
}

# module for s3
module "s3" {
  source = "./modules/s3"
}
