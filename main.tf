resource "aws_s3_bucket" "lambda_layer_bucket" {
  bucket_prefix = var.s3_bucket_name_prefix
  force_destroy = true
}

resource "aws_s3_object" "lambda_layer_object" {
  bucket = aws_s3_bucket.lambda_layer_bucket.id
  key    = "${var.lambda_layer_name}.zip"
  source = var.lambda_layer_zip_path
  etag   = filemd5(var.lambda_layer_zip_path)
}

resource "aws_lambda_layer_version" "lambda_layer" {
  layer_name = var.lambda_layer_name
  s3_bucket  = aws_s3_bucket.lambda_layer_bucket.id
  s3_key     = aws_s3_object.lambda_layer_object.key

  # Specify the runtimes your layer is compatible with
  compatible_runtimes = var.layer_compatible_runtimes
}