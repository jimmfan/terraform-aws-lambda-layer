# terraform-aws-lambda-layer
    module "lambda_layer" {
        source  = "./aws-lambda-layer-module"

        # Pass in required variables
        s3_bucket_name       = "my-lambda-layer-bucket"
        lambda_layer_zip_path = "path/to/lambda-layer.zip"
        lambda_layer_name    = "my_lambda_layer"
    }
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.24.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lambda_layer_version.lambda_layer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version) | resource |
| [aws_s3_bucket.lambda_layer_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_object.lambda_layer_object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compatible_runtimes"></a> [compatible\_runtimes](#input\_compatible\_runtimes) | Compatible runtimes for the Lambda layer | `list(string)` | <pre>[<br>  "python3.10"<br>]</pre> | no |
| <a name="input_lambda_layer_name"></a> [lambda\_layer\_name](#input\_lambda\_layer\_name) | The name of the Lambda layer | `string` | n/a | yes |
| <a name="input_lambda_layer_zip_path"></a> [lambda\_layer\_zip\_path](#input\_lambda\_layer\_zip\_path) | The local path to the Lambda layer ZIP file | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | The name of the S3 bucket to store the Lambda layer ZIP file | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_layer_arn"></a> [lambda\_layer\_arn](#output\_lambda\_layer\_arn) | n/a |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | n/a |
<!-- END_TF_DOCS -->