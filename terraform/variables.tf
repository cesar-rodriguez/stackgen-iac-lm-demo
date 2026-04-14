
################################################################################

variable "app_name" {
  description = "Application name prefix used for resource naming"
  type        = string
  default     = "serverless-app"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region for provider configuration"
  type        = string
  default     = "us-east-1"
}

