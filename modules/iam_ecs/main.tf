# -----------------------------------------------------------------------------
# IAM ロール
# -----------------------------------------------------------------------------

# ECSタスク実行ロール (ECSエージェントがECRからイメージをプルしたり、CloudWatch Logsにログを送信したりするために必要)
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project_name}-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECSタスクロール (オプション: アプリケーションがAWSサービスにアクセスする場合)
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.project_name}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# S3 アクセス用の IAM ポリシー
resource "aws_iam_policy" "ecs_task_s3_policy" {
  name        = "${var.project_name}-ecs-task-s3-policy"
  description = "Policy for ECS task role to access S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::your-bucket-name/*" # ← 適宜置き換え
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_s3_policy_attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_task_s3_policy.arn
}

# EventBridge (CloudWatch Events) がECSタスクを起動するためのIAMロール
resource "aws_iam_role" "eventbridge_ecs_invocation_role" {
  name = "${var.project_name}-eventbridge-ecs-invocation-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "eventbridge_ecs_invocation_policy" {
  name        = "${var.project_name}-eventbridge-ecs-invocation-policy"
  description = "Policy to allow EventBridge to run ECS tasks"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "ecs:RunTask"
        Resource = "*" # セキュリティ向上のため、特定のタスク定義ARNやクラスターARNに絞り込むことを推奨
        # 例: Resource = aws_ecs_task_definition.main.arn
        Condition = {
          StringEquals = {
            "ecs:cluster" = var.ecs_cluster_arn
          }
        }
      },
      {
        # ecs:RunTask を呼び出す際に、タスク実行ロールとタスクロールを渡す権限
        Effect = "Allow"
        Action = "iam:PassRole"
        Resource = [
          aws_iam_role.ecs_task_execution_role.arn,
          aws_iam_role.ecs_task_role.arn, # タスクロールを使用する場合
        ]
        Condition = {
          StringLike = {
            # iam:PassRole の権限を ecs-tasks.amazonaws.com サービスに限定
            "iam:PassedToService" = "ecs-tasks.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eventbridge_ecs_invocation_policy_attachment" {
  role       = aws_iam_role.eventbridge_ecs_invocation_role.name
  policy_arn = aws_iam_policy.eventbridge_ecs_invocation_policy.arn
}
