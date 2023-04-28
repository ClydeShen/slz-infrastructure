
output "apis" {
  value = {
    for api in aws_api_gateway_integration.this : api.resource_id => {
      name       = api.resource_id
      invoke_arn = api.uri
    }
  }
}
