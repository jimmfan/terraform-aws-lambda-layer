variable "s3_bucket_name" {
  description = "The name of the S3 bucket to store the Lambda layer ZIP file"
  type        = string
}

variable "lambda_layer_zip_path" {
  description = "The local path to the Lambda layer ZIP file"
  type        = string
}

variable "lambda_layer_name" {
  description = "The name of the Lambda layer"
  type        = string
}

variable "compatible_runtimes" {
  description = "Compatible runtimes for the Lambda layer"
  type        = list(string)
  default     = ["python3.10"]
}

output "lambda_layer_arn" {
  value = aws_lambda_layer_version.lambda_layer.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.lambda_layer_bucket.bucket
}
