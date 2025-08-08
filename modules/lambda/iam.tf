resource "aws_iam_role" "lambda_exec" {
  name = "hello_lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}
resource "aws_iam_policy" "lambda_ecr_policy" {
  name        = "LambdaECRImagePullPolicy_1"
  description = "Allows Lambda to pull Docker image from ECR"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement : [
      {
        Sid : "LambdaECRImagePullAccess",
        Effect : "Allow",
        Action : [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:GetAuthorizationToken",
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
         "logs:PutLogEvents",
          "xray:PutTelemetryRecords",
          "xray:PutTraceSegments"
        ],
        Resource : "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role = aws_iam_role.lambda_exec.name
  #   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  policy_arn = aws_iam_policy.lambda_ecr_policy.arn
}
