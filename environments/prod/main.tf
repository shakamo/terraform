module "s3" {
  source      = "../../modules/s3"
  bucket_name = var.tfstate_bucket_name
}

module "vpc" {
  source = "../../modules/vpc"
}
