 output "api_url" {
   value = aws_apigatewayv2_api.http_api.api_endpoint
}
output "full_api_url" {
value = "${aws_apigatewayv2_api.http_api.api_endpoint}/${var.route_key}"
}
output "api_gateway_arn" {
    value = aws_apigatewayv2_api.http_api.execution_arn
}
