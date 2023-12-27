module "iam_github_oidc_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"

  # This should be updated to suit your organization, repository, references/branches, etc.
  subjects = ["shakamo/*:*"]

  policies = {
    additional = aws_iam_policy.additional.arn
  }

  tags = {
    Environment = "test"
  }
}

resource "aws_iam_policy" "additional" {
  name        = "github-oidc-additional"
  description = "Additional test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject*",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::booklyn-public/**",
        "arn:aws:s3:::booklyn-public"]
      },
    ]
  })
}
