# ==================================================================
# CREATE OPSGENIE INTEGRATION
# ==================================================================

resource "opsgenie_api_integration" "this" {
  for_each                       = toset(local.opsgenie_integrations)
  name                           = each.key
  type                           = "AmazonSecurityHub"
  enabled                        = true
  allow_write_access             = true
  ignore_responders_from_payload = false
  suppress_notifications         = false
  owner_team_id                  = opsgenie_team.this.id
  lifecycle {
    ignore_changes = [
      enabled
    ]
  }
}
