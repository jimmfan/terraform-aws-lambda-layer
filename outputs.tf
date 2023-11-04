output "lambda_layer_arn" {
  value = aws_lambda_layer_version.lambda_layer.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.lambda_layer_bucket.bucket
}
