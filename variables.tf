variable "aws_region" {
  description = "The AWS region where the infrastructure will be deployed (e.g., us-east-1)."
  type        = string
}

variable "route_key" {
  description = "The route key for the API Gateway HTTP API, typically in the format 'METHOD /path' (e.g., 'GET /users')."
  type        = string
}
variable "aws_lambda_function_name" {
    description = "The lambda function name"
    type = string
}

variable "cognito_user_pool_name" {
  description = "The name of the AWS Cognito User Pool to be created or referenced."
  type        = string
}

variable "cognito_user_pool_client_name" {
  description = "The name of the client application for the Cognito User Pool."
  type        = string
}
variable "project_tags" {
  description = "A map of tags to assign to the Lambda function."
  type        = map(string)
}
