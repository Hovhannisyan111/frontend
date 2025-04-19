# S3 Bucket Module

This module creates an S3 bucket to store static files such as the `index.html` file for the frontend application.

## Usage

```hcl
module "s3" {
  source      = "git::https://github.com/Hovhannisyan111/frontend.git//terraform/modules/bucket?ref=main"
  bucket_name = "frontend-created-bucket-789"
}
