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
          AWS = local.opsgenie_aws_accounts_roles
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "sts:ExternalId" = [local.opsgenie_api_endpoint_security_hub]
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
