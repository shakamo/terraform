provider "aws" {
  region  = "ap-northeast-1"
  profile = "default"
  default_tags {
    tags = {
      cs_terraform_examples = "aws_db_cluster_snapshot/simple"
    }
  }
}
