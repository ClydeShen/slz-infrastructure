variable "LAMBDA_RUNTIME" {
  default     = "nodejs16.x"
  description = "Lambda Runtime"
}

variable "function_name" {
  type = string
}

variable "description" {
  type = string
}

variable "role_arn" {
  type = string
}


variable "lambda_bucket_id" {
  type = string
}
