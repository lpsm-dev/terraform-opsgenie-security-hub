# ==================================================================
# CREATE IAM ROLE
# ==================================================================

resource "aws_iam_role" "this" {
  name        = "opsgenie-security-hub-role"
  description = "IAM role to allow Opsgenie to access Security Hub"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::089311581210:role/opsgenie-securityhub-app",
            "arn:aws:iam::401089113854:role/opsgenie-securityhub-app",
            "arn:aws:iam::838921230308:role/opsgenie-securityhub-app",
            "arn:aws:iam::028860521379:role/opsgenie-securityhub-app"
          ]
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "sts:ExternalId" = [opsgenie_api_integration.aws_security_hub.api_key]
          }
        }
      }
    ]
  })
}

# ==================================================================
# CREATE IAM POLICY
# ==================================================================

resource "aws_iam_policy" "this" {
  name        = "opsgenie-security-hub-policy"
  description = "Policy to allow opsgenie to access security hub"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "VisualEditor0"
        Effect   = "Allow"
        Action   = ["securityhub:GetFindings", "securityhub:BatchUpdateFindings"]
        Resource = ["arn:aws:securityhub:*:*:*"]
      }
    ]
  })
}

# ==================================================================
# CREATE IAM ROLE POLICY ATTACHMENT
# ==================================================================

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
