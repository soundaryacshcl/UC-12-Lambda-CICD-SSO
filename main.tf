


module "lambda" {
  source = "./modules/lambda"
  api_gateway_arn = module.api_gateway.api_gateway_arn
  aws_lambda_function_name = var.aws_lambda_function_name
  project_tags = var.project_tags
}

module "api_gateway" {
  source = "./modules/apigateway"
  lambda_integration_uri_arn = module.lambda.lambda_integration_uri_arn
  aws_cognito_arn = module.aws_cognito.aws_cognito_arn
  cognito_user_pool_id = module.aws_cognito.cognito_user_pool_id
  cognito_user_pool_client_id = module.aws_cognito.cognito_user_pool_client_id
  aws_region = var.aws_region
  route_key= var.route_key
  project_tags = var.project_tags
}

module "aws_cognito" {
  source = "./modules/cognito"
  aws_region = var.aws_region
  cognito_user_pool_name = var.cognito_user_pool_name
  cognito_user_pool_client_name = var.cognito_user_pool_client_name
  full_api_url = module.api_gateway.full_api_url
  project_tags = var.project_tags
}
