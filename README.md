# terraform-aws-lambda-layer

module "lambda_layer" {
  source  = "./aws-lambda-layer-module" 

  # Pass in required variables
  s3_bucket_name       = "my-lambda-layer-bucket"
  lambda_layer_zip_path = "path/to/lambda-layer.zip"
  lambda_layer_name    = "my_lambda_layer"
}