variable "lambda_integration_uri_arn" {
  description = "The ARN of the Lambda function to be integrated with API Gateway as the backend."
  type        = string
}

variable "aws_cognito_arn" {
  description = "The ARN of the AWS Cognito User Pool authorizer used to secure API Gateway routes."
  type        = string
}

variable "cognito_user_pool_id" {
  description = "The ID of the Cognito User Pool used for user authentication."
  type        = string
}

variable "cognito_user_pool_client_id" {
  description = "The Client ID of the Cognito User Pool application used by frontend clients to authenticate."
  type        = string
}

variable "aws_region" {
  description = "The AWS region where resources will be deployed."
  type        = string
}

variable "route_key" {
  description = "The route key for the API Gateway HTTP API (e.g., GET /resource or POST /login)."
  type        = string
}
variable "project_tags" {
  description = "A map of tags for my project"
  type        = map(string) 
}
