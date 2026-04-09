
################################################################################

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "aws-simple-lambda-demo"
}

variable "lambda_execution_role_arn" {
  description = "IAM role ARN assumed by the Lambda function"
  type        = string
}

variable "cloudwatch_log_group_name" {
  description = "CloudWatch log group name for the Lambda function"
  type        = string
  default     = "/aws/lambda/aws-simple-lambda-demo"
}

