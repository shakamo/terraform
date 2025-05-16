variable "project_name" {
  description = "プロジェクト名 (リソース名のプレフィックスとして使用)"
  type        = string
  default     = "booklyn"
}
variable "ecs_cluster_arn" {
  description = ""
  type        = string
}
variable "vpc_arn" {
  type = string
}
