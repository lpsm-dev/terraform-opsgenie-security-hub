# ==================================================================
# CREATE OPSGENIE TEAM
# ==================================================================

resource "opsgenie_team" "this" {
  name                     = var.opsgenie_team_name
  description              = var.opsgenie_team_description
  delete_default_resources = true
  dynamic "member" {
    for_each = try(data.opsgenie_user.users, [])
    content {
      id   = member.value.id
      role = var.opsgenie_users[index(var.opsgenie_users.*.user_email, member.key)].role
    }
  }
}

# ==================================================================
# CREATE OPSGENIE INTEGRATION
# ==================================================================

resource "opsgenie_api_integration" "aws_security_hub" {
  name                           = "aws-security-hub-findings"
  type                           = "AmazonSecurityHub"
  enabled                        = true
  allow_write_access             = true
  ignore_responders_from_payload = false
  suppress_notifications         = false
  owner_team_id                  = opsgenie_team.this.id
}
