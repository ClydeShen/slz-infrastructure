# setup terraform variables for AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY by

#AWS authentication variables
variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
}
variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Key"
}

variable "AWS_REGION" {
  default     = "ap-southeast-2"
  description = "Sydney Region"
}

variable "APP_NAME" {
  default     = "slz"
  description = "Application Name"
}

variable "ENV" {
  default     = "development"
  description = "Environment"
}

