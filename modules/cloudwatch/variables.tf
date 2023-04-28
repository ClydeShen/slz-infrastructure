variable "AWS_REGION" {
  type = string
}

variable "AWS_ACCOUNT_ID" {
  type = string
}

variable "lambda_functions" {
  type = map(object({
    name       = string
    arn        = string
    invoke_arn = string
  }))
}

