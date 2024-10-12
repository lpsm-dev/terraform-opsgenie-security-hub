# ==================================================================
# DATAS - AWS DEFAULT
# ==================================================================

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# ==================================================================
# DATAS - OPSGENIE
# ==================================================================

data "opsgenie_user" "users" {
  for_each = { for user in var.opsgenie_users : user.user_email => user }
  username = each.key
}
