variable "project_name" {
  description = "プロジェクト名 (リソース名のプレフィックスとして使用)"
  type        = string
  default     = "booklyn"
}
variable "task_cpu" {
  description = "タスクに割り当てるCPUユニット (Fargateの有効な値)"
  type        = string
  default     = "256" # 0.25 vCPU
}

variable "task_memory" {
  description = "タスクに割り当てるメモリ (MB単位、Fargateの有効な値)"
  type        = string
  default     = "512" # 0.5 GB
}
variable "docker_image_url" {
  description = "ECRなどにプッシュされたDockerイメージのURL (例: 123456789012.dkr.ecr.ap-northeast-1.amazonaws.com/my-app:latest)"
  type        = string
  default     = "123456789012.dkr.ecr.ap-northeast-1.amazonaws.com/your-image-name:latest" # ご自身のイメージURLに置き換えてください
}
variable "aws_region" {
  description = "デプロイするAWSリージョン"
  type        = string
  default     = "ap-northeast-1"
}
variable "ecs_task_execution_role_arn" {
  type = string
}
variable "ecs_task_role_arn" {
  type = string
}
variable "aws_cloudwatch_log_group_name" {
  type = string
}
