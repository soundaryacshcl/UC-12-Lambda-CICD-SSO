# resource "aws_security_group" "lambda_sg" {
#   name   = "lambda-sg"
#   # vpc_id = var.vpc_id

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }


data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_app/hello.py"
  output_path = "${path.module}/lambda_app/hello.zip"
}
resource "aws_lambda_function" "lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = var.aws_lambda_function_name
  role             =  aws_iam_role.lambda_exec.arn
  handler          = "hello.handler"
  runtime          = "python3.11"
  timeout          = 30
  memory_size      = 128
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)
  depends_on       = [aws_iam_role.lambda_exec]
   tags            = var.project_tags
}


resource "aws_lambda_permission" "apigw_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${var.api_gateway_arn}/*"
}


resource "aws_cloudwatch_log_group" "api_gateway" {
  name              = "/aws/apigateway/lambda-http-api"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/my-docker-lambda"
  retention_in_days = 7
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "Docker-Lambda-dashboard"
  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            [
              "AWS/ApiGateway",
              "4XXError",
              "ApiName",
              "lambda-http-api"
            ],
            [
              "AWS/ApiGateway",
              "5XXError",
              "ApiName",
              "lambda-http-api"
            ]
          ]
          period = 300
          stat   = "Sum"
          region = "us-east-1"
          title  = "API Gateway Errors"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            [
              "AWS/Lambda",
              "Errors",
              "FunctionName",
              "my-docker-lambda"
            ],
            [
              "AWS/Lambda",
              "Throttles",
              "FunctionName",
              "my-docker-lambda"
            ]
          ]
          period = 300
          stat   = "Sum"
          region = "us-east-1"
          title  = "Lambda Errors/Throttles"
        }
      }
    ]
  })
}
