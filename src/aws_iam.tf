# ==================================================================
# CREATE IAM ROLE
# ==================================================================

resource "aws_iam_role" "this" {
  name        = "opsgenie-sh-role"
  description = "IAM role to allow Opsgenie access the Security Hub"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = local.opsgenie_atlassian_aws_accounts_roles
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "sts:ExternalId" = values(local.opsgenie_api_keys)
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
  name        = "opsgenie-sh-policy"
  description = "Policy to allow findings operations in Security Hub"
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
