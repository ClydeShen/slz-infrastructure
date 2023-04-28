# variable "AWS_REGION" {
#   type = string
# }

# variable "AWS_ACCOUNT_ID" {
#   type = string
# }

variable "LAMBDA_RUNTIME" {
  default     = "nodejs16.x"
  description = "Lambda Runtime"
}

# variable "function_name" {
#   type = string
# }

# variable "description" {
#   type = string
# }

variable "role_arn" {
  type = string
}


variable "lambda_bucket_id" {
  type = string
}

variable "allow_api_gateway" {
  type    = bool
  default = true
}

variable "lambda_names" {
  type    = list(string)
  default = []
}
