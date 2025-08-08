variable "aws_region" {
  description = "The AWS region where the resources (e.g., Lambda, API Gateway) will be deployed."
  type        = string
}
variable "cognito_user_pool_name" {
  description = "The name of the AWS Cognito User Pool to be created or referenced."
  type        = string
}

variable "cognito_user_pool_client_name" {
  description = "The name of the client application for the Cognito User Pool."
  type        = string
}

variable "full_api_url" {
  description = "The full URL endpoint for the deployed API Gateway route, typically used for invoking the API."
  type        = string
}
variable "project_tags" {
  description = "A map of tags for my project"
  type        = map(string) 
}
