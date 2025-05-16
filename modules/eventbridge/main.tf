
# -----------------------------------------------------------------------------
# CloudWatch Event Rule (スケジューラー)
# -----------------------------------------------------------------------------
resource "aws_cloudwatch_event_rule" "scheduler" {
  name                = "${var.project_name}-scheduler-rule"
  description         = "Run ${var.project_name} task on a schedule"
  schedule_expression = "cron(0 0 17 12 ? *)" # 例: "cron(0 2 * * ? *)" (毎日午前2時 JST) -> UTCで "cron(0 17 * * ? *)"
}

# -----------------------------------------------------------------------------
# CloudWatch Event Target (ECSタスクを起動)
# -----------------------------------------------------------------------------
resource "aws_cloudwatch_event_target" "ecs_task_scheduler" {
  rule     = aws_cloudwatch_event_rule.scheduler.name
  arn      = var.ecs_cluster_arn                     # ターゲットはECSクラスター
  role_arn = var.eventbridge_ecs_invocation_role_arn # EventBridgeがECSタスクを起動するためのロール

  ecs_target {
    task_count          = 1                           # 起動するタスクの数
    task_definition_arn = var.ecs_task_definition_arn # 実行するタスク定義
    launch_type         = "FARGATE"

    network_configuration {
      subnets          = var.public_subnets          # タスクを実行するサブネット
      security_groups  = var.task_security_group_ids # タスクに適用するセキュリティグループ
      assign_public_ip = "true"                      # FargateタスクがECRや外部APIにアクセスするためにパブリックIPが必要な場合。プライベートサブネットでNAT Gateway経由の場合は "DISABLED" でも可。
    }

    # Fargateプラットフォームバージョン (通常はLATESTで問題ありません)
    # platform_version = "LATEST"
  }

  # リトライポリシー (オプション)
  # retry_policy {
  #   maximum_event_age_in_seconds = 3600 # 1時間
  #   maximum_retry_attempts      = 3
  # }

  # デッドレターキュー (DLQ) の設定 (オプション)
  # ターゲットの呼び出しに失敗した場合にメッセージを送信するSQSキュー
  # dead_letter_config {
  #   arn = aws_sqs_queue.scheduler_dlq.arn # 事前にSQSキューを作成しておく必要があります
  # }
}

# (オプション) デッドレターキュー用のSQSキュー
# resource "aws_sqs_queue" "scheduler_dlq" {
#   name = "${var.project_name}-scheduler-dlq-${var.environment}"
#   tags = {
#     Name        = "${var.project_name}-scheduler-dlq-${var.environment}"
#     Environment = var.environment
#     Project     = var.project_name
#   }
# }
