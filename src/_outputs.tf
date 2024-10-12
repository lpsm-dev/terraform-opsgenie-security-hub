# ==================================================================
# OUTPUTS - AWS DEFAULT
# ==================================================================

output "aws_account_id" {
  value       = local.aws_account_id
  description = "Selected AWS Account ID"
}

output "aws_region" {
  value       = data.aws_region.current.name
  description = "Details about selected AWS region"
}

# ==================================================================
# OUTPUTS - AWS IAM
# ==================================================================

output "opsgenie_security_hub_role_name" {
  value       = aws_iam_role.this.name
  description = "Name of the IAM Role created for Opsgenie Security Hub Integration"
}

output "opsgenie_security_hub_role_arn" {
  value       = aws_iam_role.this.arn
  description = "ARN of the IAM Role created for Opsgenie Security Hub Integration"
}
