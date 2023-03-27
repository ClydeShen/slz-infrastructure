# setup terraform variables for AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY by
# using terraform workspace environment variables
variable "AWS_ACCESS_KEY_ID" {
  type        = string
  description = "AWS Access Key ID"
}

variable "AWS_SECRET_ACCESS_KEY" {
  type        = string
  description = "Aws Secret Access Key"
}

variable "AWS_REGION" {
  dedefault   = "ap-southeast-2"
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

