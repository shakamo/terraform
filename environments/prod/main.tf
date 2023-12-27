module "s3" {
  source      = "../../modules/s3"
  bucket_name = var.tfstate_bucket_name
  versioning  = var.tfstate_versioning
}

module "s3_public" {
  source      = "../../modules/s3_public"
  bucket_name = var.public_bucket_name
}

module "vpc" {
  source = "../../modules/vpc"
}

module "iam" {
  source = "../../modules/iam"
}
