

output "eventbridge_ecs_invocation_role_arn" {
  description = "作成されたECSクラスターのARN"
  value       = aws_iam_role.eventbridge_ecs_invocation_role.arn
}
output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}
