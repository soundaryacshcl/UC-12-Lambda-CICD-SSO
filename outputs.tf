
output "lambda_integration_uri_arn" {
    value =  module.lambda.lambda_integration_uri_arn
}
output "api_gateway_arn" {
    value = module.api_gateway.api_gateway_arn
}
output "full_api_url" {
value = "${module.api_gateway.api_url}/${var.route_key}"
}

output "cognito_login_url" {
  value = module.aws_cognito.cognito_login_url
  }
