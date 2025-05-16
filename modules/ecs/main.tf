# -----------------------------------------------------------------------------
# ECS クラスター
# -----------------------------------------------------------------------------
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"
}

# -----------------------------------------------------------------------------
# ECS タスク定義
# -----------------------------------------------------------------------------
resource "aws_ecs_task_definition" "main" {
  family                   = "${var.project_name}-task"
  requires_compatibilities = ["FARGATE"]     # Fargate起動タイプを指定
  network_mode             = "awsvpc"        # Fargateにはawsvpcネットワークモードが必要
  cpu                      = var.task_cpu    # タスク全体のCPUユニット
  memory                   = var.task_memory # タスク全体のメモリ (MB)
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn # アプリケーション固有の権限を持つロール (オプション)

  # コンテナ定義
  container_definitions = jsonencode([
    {
      name      = "${var.project_name}-container"
      image     = var.docker_image_url      # ECRリポジトリURIとイメージタグ
      cpu       = tonumber(var.task_cpu)    # コンテナに割り当てるCPUユニット (タスク全体のCPUと同じかそれ以下)
      memory    = tonumber(var.task_memory) # コンテナに割り当てるメモリ (MB、タスク全体のメモリと同じかそれ以下)
      essential = true                      # このコンテナが停止するとタスク全体が停止するかどうか

      # ポートマッピング (スケジュラージョブの場合、通常は不要)
      # portMappings = [
      #   {
      #     containerPort = 8080 # アプリケーションがリッスンするポート
      #     protocol      = "tcp"
      #   }
      # ]

      # 環境変数 (必要に応じて設定)
      environment = [
        # {
        #   name  = "APP_ENV"
        #   value = var.environment
        # },
        # {
        #   name  = "AWS_REGION"
        #   value = var.aws_region
        # }
        # {
        #   name  = "DATABASE_URL"
        #   value = "your_database_url_here"
        # }
      ]

      # AWS Secrets Manager や Systems Manager Parameter Store から機密情報を渡す場合 (オプション)
      # secrets = [
      #   {
      #     name      = "API_KEY"
      #     valueFrom = "arn:aws:secretsmanager:your-region:your-account-id:secret:your-secret-name-XXXXXX"
      #   },
      #   {
      #     name      = "DB_PASSWORD"
      #     valueFrom = "arn:aws:ssm:your-region:your-account-id:parameter/your-parameter-name"
      #   }
      # ]

      # ログ設定
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.aws_cloudwatch_log_group_name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs" # ログストリームのプレフィックス
        }
      }
    }
  ])
}
