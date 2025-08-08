# variable "private_subnet_id" {
#     description = "private_subnet_id"
#     type = list(string)
# }
# variable "vpc_id" {
#     description = "the main vpc ID"
#     type = string
# }
# variable "aws_apigatewayv2_arn" {
#     description = "aws_apigatewayv2_arn"
#     type = string
# }
variable "api_gateway_arn" {
  description = "The ARN of the API Gateway used to grant invoke permissions to the Lambda function."
  type        = string
}
variable "aws_lambda_function_name" {
    description = "The lambda function name"
    type = string
}

variable "project_tags" {
  description = "A map of tags for my project"
  type        = map(string)
#   default     = {
#     Environment = "dev"
#     Project     = "HelloLambdaCognito"
#     ManagedBy   = "Terraform"
#   }
}
