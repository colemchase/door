variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "lambda_arn" {
  description = "ARN of the Lambda function to integrate"
  type        = string
}
