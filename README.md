# Simple Lambda + Terraform

- `aws configure`
- `tf plan`
- `tf apply`
- `aws lambda invoke --invocation-type RequestResponse --function-name <lambda_name> --region us-east-1 --log-type Tail --payload '{"key1":"value1"}' /tmp/resp.json | jq .LogResult | sed 's/"//g' | base64 --decode`