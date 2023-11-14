# Example Usages
    module "lambda_layer" {
        source  = "./aws-lambda-layer-module"

        # Pass in required variables
        s3_bucket_name       = "my-lambda-layer-bucket"
        lambda_layer_zip_path = "path/to/lambda-layer.zip"
        lambda_layer_name    = "my_lambda_layer"
    }

# Example of CD Workflow
    name: Continuous Deployment

    on:
      push:
          branches:
          - main
    workflow_dispatch:

    env:
      repo_name: ${{ github.event.repository.name }}
      python_version: "3.10"
      tf_vars_path: .auto.tfvars

    jobs:
      create-lambda-layer-zip:
        name: Create lambda layer zip
        runs-on: ubuntu-20.04
        permissions:
        contents: write

        steps:
        - name: Checkout repository
            uses: actions/checkout@v3

        - name: Set up Python ${{ env.python_version }}
            uses: actions/setup-python@v2
            with:
            python-version: ${{ env.python_version }}

        - name: Install aws-xray-sdk
            run: |
            pip3 install aws-xray-sdk -t ./python

        - name: Zip aws-xray-sdk
            run: |
            zip -r xray.zip ./python

        - name: Upload xray.zip artifact
            uses: actions/upload-artifact@v3
            with:
            name: xray
            path: ./xray.zip


    deploy_lambda_layer:
        name: Deploy lambda layer
        needs: create-lambda-layer-zip
        runs-on: ubuntu-20.04
        steps:
        - name: Checkout code
            uses: actions/checkout@v3

        - name: Download xray zip from GitHub Artifacts
            uses: actions/download-artifact@v3
            with:
            name: xray
            path: ./ # Downloads to the root directory of the workspace

        - name: Setup Terraform
            uses: hashicorp/setup-terraform@v2
            with:
            cli_config_credentials_token: ${{ secrets.TF_API_TOKEN }}
            terraform_version: '1.6.3' # Specify the version of Terraform here

        - name: Deploy with Terraform
            run: |
            terraform init
            terraform apply -auto-approve
            working-directory: ./terraform_dir

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
| <a name="input_lambda_layer_name"></a> [lambda\_layer\_name](#input\_lambda\_layer\_name) | The name of the Lambda layer | `string` | n/a | yes |
| <a name="input_lambda_layer_zip_path"></a> [lambda\_layer\_zip\_path](#input\_lambda\_layer\_zip\_path) | The local path to the Lambda layer ZIP file | `string` | n/a | yes |
| <a name="input_layer_compatible_runtimes"></a> [layer\_compatible\_runtimes](#input\_layer\_compatible\_runtimes) | Compatible runtimes for the Lambda layer | `list(string)` | <pre>[<br>  "python3.10"<br>]</pre> | no |
| <a name="input_s3_bucket_name_prefix"></a> [s3\_bucket\_name\_prefix](#input\_s3\_bucket\_name\_prefix) | The name of the S3 bucket to store the Lambda layer ZIP file | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_layer_arn"></a> [lambda\_layer\_arn](#output\_lambda\_layer\_arn) | n/a |
<!-- END_TF_DOCS -->