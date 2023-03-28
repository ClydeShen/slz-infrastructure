# variable for lambda_zip_file_path
variable "lambda_zip_file_path" {
  default     = "slz-lambda-fns.zip"
  description = "Lambda Zip File Path"
}

# variables for lambda functions, e.g. openai, some
variable "lambda_functions" {
  default     = ["openai", "some"]
  description = "list of lambda functions"
}
