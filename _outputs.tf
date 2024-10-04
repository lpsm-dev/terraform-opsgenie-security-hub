# ==================================================================
# OUTPUTS - AWS
# ==================================================================

output "aws_account_id" {
  description = "Selected AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  description = "Details about selected AWS region"
  value       = data.aws_region.current.name
}

# ==================================================================
# OUTPUTS - AWS IAM
# ==================================================================

output "opsgenie_security_hub_role_name" {
  description = "Name of the IAM Role created for Opsgenie Security Hub Integration"
  value       = aws_iam_role.this.name
}

output "opsgenie_security_hub_role_arn" {
  description = "ARN of the IAM Role created for Opsgenie Security Hub Integration"
  value       = aws_iam_role.this.arn
}
