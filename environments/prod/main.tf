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

module "iam_oidc" {
  source = "../../modules/iam_oidc"
}

module "iam_ecs" {
  source          = "../../modules/iam_ecs"
  project_name    = "booklyn"
  vpc_arn         = module.vpc.vpc_arn
  ecs_cluster_arn = module.ecs.ecs_cluster_arn
}

module "s3_web_automation" {
  source      = "../../modules/s3"
  bucket_name = "booklyn-web-automation"
}

module "ecs" {
  source                        = "../../modules/ecs"
  ecs_task_execution_role_arn   = module.iam_ecs.ecs_task_execution_role_arn
  ecs_task_role_arn             = module.iam_ecs.ecs_task_role_arn
  aws_cloudwatch_log_group_name = module.cloudwatch_logs.aws_cloudwatch_log_group_name
}

module "eventbridge" {
  source                              = "../../modules/eventbridge"
  ecs_cluster_arn                     = module.ecs.ecs_cluster_arn
  eventbridge_ecs_invocation_role_arn = module.iam_ecs.eventbridge_ecs_invocation_role_arn
  vpc_arn                             = module.vpc.vpc_arn
  ecs_task_definition_arn             = module.ecs.ecs_task_definition_arn
  public_subnets                      = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  task_security_group_ids             = ["sg-00de2a07cb1fe0844"]

}

module "cloudwatch_logs" {
  source = "../../modules/cloudwatch_logs"
}
