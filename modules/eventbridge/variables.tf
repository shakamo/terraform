variable "project_name" {
  description = "プロジェクト名 (リソース名のプレフィックスとして使用)"
  type        = string
  default     = "booklyn"
}
variable "ecs_cluster_arn" {
  description = ""
  type        = string
}
variable "eventbridge_ecs_invocation_role_arn" {
  type = string
}
variable "vpc_arn" {
  type = string
}
variable "ecs_task_definition_arn" {
  type = string
}
variable "public_subnets" {
  type = list(string)
}
variable "task_security_group_ids" {
  type = list(string)
}
