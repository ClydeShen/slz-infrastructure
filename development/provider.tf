# setup terraform provider as aws
# initialize terraform provider as aws
provider "aws" {
  region     = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

terraform {
  required_prioviders {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
