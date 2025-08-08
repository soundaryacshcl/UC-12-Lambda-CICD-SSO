output "aws_cognito_arn" {
    value = aws_cognito_user_pool.main.arn
}
output "cognito_user_pool_id" {
value = aws_cognito_user_pool.main.id
}

output "cognito_user_pool_client_id" {
value = aws_cognito_user_pool_client.main.id
}
output "cognito_login_url" {
  value = "https://${aws_cognito_user_pool_domain.default_domain.domain}.auth.${var.aws_region}.amazoncognito.com/login?client_id=${aws_cognito_user_pool_client.main.id}&response_type=token&scope=email+openid+profile+aws.cognito.signin.user.admin&redirect_uri=${var.full_api_url}"
}
