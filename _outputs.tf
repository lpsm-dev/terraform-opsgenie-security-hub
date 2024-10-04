# ==================================================================
# OUTPUTS - AWS
# ==================================================================

output "opsgenie_security_hub_role_name" {
  value = aws_iam_role.this.name
}

output "opsgenie_security_hub_role_arn" {
  value = aws_iam_role.this.arn
}
