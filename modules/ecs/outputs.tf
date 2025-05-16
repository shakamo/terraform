
output "ecs_cluster_arn" {
  description = "作成されたECSクラスターのARN"
  value       = aws_ecs_cluster.main.arn
}
output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.main.arn
}
