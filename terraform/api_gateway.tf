resource "aws_apigatewayv2_api" "http_api" {
  name          = "secure-http-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.secure_api.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "api_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "POST /"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "prod" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "prod"
  auto_deploy = true

  default_route_settings {
    throttling_burst_limit = 10
    throttling_rate_limit  = 5
  }
}

resource "aws_lambda_permission" "allow_apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.secure_api.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/prod/POST/"
}

# Optional WAF association (commented if not needed)
# resource "aws_wafv2_web_acl_association" "api_waf_attach" {
#   resource_arn = "${aws_apigatewayv2_api.http_api.execution_arn}/prod"
#   web_acl_arn  = aws_wafv2_web_acl.api_waf.arn
# }

output "api_url" {
  description = "Base URL for your API Gateway endpoint"
  value       = "${aws_apigatewayv2_api.http_api.api_endpoint}/prod/"
}
