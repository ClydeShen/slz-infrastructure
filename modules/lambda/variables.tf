# variable for lambda_zip_file_path


# variables for lambda functions, e.g. openai, some
variable "lambda_functions" {
  default     = ["openai", "some"]
  description = "list of lambda functions"
}

variable "LAMBDA_RUNTIME" {
  type = string
}

variable "lambda_zip_file" {
  type = string
}
