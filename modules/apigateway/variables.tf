variable "AWS_REGION" {
  type = string
}

variable "AWS_ACCOUNT_ID" {
  type = string
}

# variable "function_name" {
#   type = string
# }

# variable "description" {
#   type = string
# }

# variable "resource_path" {
#   type = string
# }

variable "http_method" {
  type    = string
  default = "ANY"
}

# variable "uri" {
#   type = string
# }

variable "lambda_functions" {
  type = map(object({
    name       = string
    arn        = string
    invoke_arn = string
  }))
}
