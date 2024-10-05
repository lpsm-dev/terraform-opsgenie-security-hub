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
