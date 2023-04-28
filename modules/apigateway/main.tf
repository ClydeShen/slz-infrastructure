# setup api gateway to invoke lambda
resource "aws_api_gateway_rest_api" "this" {
  name = "test-api-gateway"
}

resource "aws_api_gateway_resource" "this" {
  for_each    = var.lambda_functions
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = each.value.name
}

# setup api gateway method
resource "aws_api_gateway_method" "this" {
  for_each      = var.lambda_functions
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.this[each.key].id
  http_method   = var.http_method
  authorization = "NONE"
}

# setup api gateway integration
resource "aws_api_gateway_integration" "this" {
  for_each                = var.lambda_functions
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.this[each.key].id
  http_method             = aws_api_gateway_method.this[each.key].http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = each.value.invoke_arn
}

# setup api gateway deployment
resource "aws_api_gateway_deployment" "this" {
  for_each    = var.lambda_functions
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = "api"
  # triggers = {
  #   redeployment = sha1(jsonencode([
  #     aws_api_gateway_rest_api.this,
  #     aws_api_gateway_resource.this,
  #     aws_api_gateway_method.this,
  #     aws_api_gateway_integration.this,
  #   ]))
  # }
}

# setup api gateway permission
resource "aws_lambda_permission" "this" {
  for_each      = var.lambda_functions
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = each.value.name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/*"
}
