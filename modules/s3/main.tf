module "s3-bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = var.bucket_name
  versioning = {
    enabled = var.versioning
  }
}
